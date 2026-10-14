#!/bin/bash
# Starts the Vault MCP server for VS Code and Claude Code.
# HashiQube's Vault gets a new root token every time vault/vault.sh runs, so the token is
# read at startup: VAULT_TOKEN (set by vexport), else the root token in /etc/vault/init.file.

# shellcheck source=/dev/null
[ -f "${HOME}/.hashiqube.env" ] && . "${HOME}/.hashiqube.env"

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
if [ -z "${VAULT_TOKEN}" ] && [ -r /etc/vault/init.file ]; then
  VAULT_TOKEN=$(grep 'Initial Root Token' /etc/vault/init.file | cut -d ':' -f2 | tr -d ' ')
  export VAULT_TOKEN
fi

if ! command -v vault-mcp-server > /dev/null; then
  echo "vault-mcp-server not found, run: bash /vagrant/.devcontainer/install-tools.sh" >&2
  exit 1
fi
if [ -z "${VAULT_TOKEN}" ]; then
  echo "No Vault token found, start Vault first with: bash vault/vault.sh" >&2
fi

exec vault-mcp-server stdio
