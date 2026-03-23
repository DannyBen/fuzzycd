#!/usr/bin/env bash

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

create_workspace() {
  local name=${1:-default}
  WORKSPACE="$REPO_ROOT/tmp/shellkin-$name-$$-$RANDOM"
  HOME_DIR="$WORKSPACE/home"
  HISTORY_FILE="$WORKSPACE/history"

  mkdir -p "$WORKSPACE" "$HOME_DIR"

  export HOME="$HOME_DIR"
  export FUZZYCD_HISTORY_FILE="$HISTORY_FILE"
  export FUZZYCD_TTY_FORCE=1

  OLD_PWD=$PWD
  cd "$WORKSPACE" || return 1
  defer rm -rf "$WORKSPACE"
  defer cd "$OLD_PWD"

  # shellcheck disable=SC1091
  source "$REPO_ROOT/fuzzycd"
}

run_in_current_shell() {
  local command=$1
  local stdout_file="$WORKSPACE/stdout"
  local stderr_file="$WORKSPACE/stderr"

  : > "$stdout_file"
  : > "$stderr_file"
  eval "$command" >"$stdout_file" 2>"$stderr_file"
  LAST_EXIT_CODE=$?
  LAST_STDOUT=$(cat "$stdout_file")
  LAST_STDERR=$(cat "$stderr_file")
}

workspace_path() {
  local path=$1
  printf '%s/%s\n' "$WORKSPACE" "$path"
}
