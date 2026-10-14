# shellcheck shell=bash
# Shared environment for every terminal in the HashiQube DevContainer, and for Claude Code.
#
# Variables set with `vexport` are stored in ~/.hashiqube.env and picked up by every
# terminal, including ones that are already open, on their next prompt.
#
# devcontainer.json sets BASH_ENV to this file, so every non-interactive bash, such as
# the commands Claude Code and other AI assistants run, also loads ~/.hashiqube.env.
# A plain `export` only lives in the terminal you typed it in. Use `vexport` to share it.
#
#   vexport AWS_ACCESS_KEY_ID=AKIA... AWS_SECRET_ACCESS_KEY=...   # set in all terminals
#   vexport KUBECONFIG=~/.kube/config                             # set in all terminals
#   vunset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY                # unset in all terminals
#   venv                                                          # list shared variables

HASHIQUBE_ENV_FILE="${HOME}/.hashiqube.env"

__hashiqube_env_write() {
  touch "${HASHIQUBE_ENV_FILE}"
  chmod 600 "${HASHIQUBE_ENV_FILE}"
  sed -i -e "/^export $1=/d" -e "/^unset $1\$/d" "${HASHIQUBE_ENV_FILE}"
  echo "$2" >> "${HASHIQUBE_ENV_FILE}"
}

vexport() {
  local pair
  for pair in "$@"; do
    __hashiqube_env_write "${pair%%=*}" "$(printf 'export %s=%q' "${pair%%=*}" "${pair#*=}")"
  done
  __hashiqube_env_sum=""
  __hashiqube_env_sync
}

vunset() {
  local name
  for name in "$@"; do
    __hashiqube_env_write "${name}" "unset ${name}"
    unset "${name}"
  done
  __hashiqube_env_sum=""
  __hashiqube_env_sync
}

# List shared variable names, values hidden
venv() {
  [ -f "${HASHIQUBE_ENV_FILE}" ] && sed -n 's/^export \([^=]*\)=.*/\1/p' "${HASHIQUBE_ENV_FILE}"
}

# Re-source ~/.hashiqube.env whenever any terminal changed it
__hashiqube_env_sync() {
  [ -f "${HASHIQUBE_ENV_FILE}" ] || return 0
  local sum
  sum=$(cksum < "${HASHIQUBE_ENV_FILE}")
  if [ "${sum}" != "${__hashiqube_env_sum}" ]; then
    # shellcheck source=/dev/null
    . "${HASHIQUBE_ENV_FILE}"
    __hashiqube_env_sum="${sum}"
  fi
}

__hashiqube_env_sync

# Interactive shells re-sync before every prompt
case $- in
  *i*)
    case ";${PROMPT_COMMAND};" in
      *";__hashiqube_env_sync;"*) ;;
      *) PROMPT_COMMAND="__hashiqube_env_sync${PROMPT_COMMAND:+;${PROMPT_COMMAND}}" ;;
    esac
    ;;
esac
