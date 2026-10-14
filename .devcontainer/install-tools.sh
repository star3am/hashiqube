#!/bin/bash
# Installs the HashiCorp MCP servers and the shared terminal environment (vexport) into the
# DevContainer. Runs from postCreateCommand in devcontainer.json, safe to re-run.
# https://developer.hashicorp.com/vault/docs/mcp-server
# https://developer.hashicorp.com/terraform/mcp-server

set -e

VAULT_MCP_SERVER_VERSION=${VAULT_MCP_SERVER_VERSION:-latest}
TERRAFORM_MCP_SERVER_VERSION=${TERRAFORM_MCP_SERVER_VERSION:-latest}

case "$(uname -m)" in
  x86_64) ARCH=amd64 ;;
  aarch64|arm64) ARCH=arm64 ;;
  *) ARCH=arm ;;
esac

install_hashicorp_binary() {
  local product=$1 version=$2
  if [ "${version}" == "latest" ]; then
    version=$(curl -fsSL "https://checkpoint-api.hashicorp.com/v1/check/${product}" | jq -r .current_version)
  fi
  if [ "$(command -v "${product}")" == "/usr/local/bin/${product}" ] && "${product}" --version 2>/dev/null | grep -q "${version}"; then
    echo -e '\e[38;5;198m'"++++ ${product} ${version} already installed"
    return
  fi
  echo -e '\e[38;5;198m'"++++ Installing ${product} ${version}"
  curl -fsSLo "/tmp/${product}.zip" "https://releases.hashicorp.com/${product}/${version}/${product}_${version}_linux_${ARCH}.zip"
  sudo unzip -qo "/tmp/${product}.zip" "${product}" -d /usr/local/bin
  sudo chmod +x "/usr/local/bin/${product}"
  rm -f "/tmp/${product}.zip"
}

install_hashicorp_binary vault-mcp-server "${VAULT_MCP_SERVER_VERSION}"
install_hashicorp_binary terraform-mcp-server "${TERRAFORM_MCP_SERVER_VERSION}"

# Shared environment for every interactive shell (vexport / vunset / venv)
sudo cp /vagrant/.devcontainer/etc/profile.d/vexport.sh /etc/profile.d/vexport.sh
grep -q '/etc/profile.d/vexport.sh' ~/.bashrc 2>/dev/null || echo '. /etc/profile.d/vexport.sh' >> ~/.bashrc
