#!/usr/bin/env bash

fuzzycd_run() {
  local version="0.2.4"
  local histfile=${FUZZYCD_HISTORY_FILE:-"$HOME/.fuzzycd-history"}

  _fzcd_is_dirname() {
    if [[ -d "$1" ]]; then
      return 0

    elif [[ -n "$CDPATH" ]]; then
      IFS=':' read -ra cdpath <<<"$CDPATH"
      for path in "${cdpath[@]}"; do
        [[ -d "$path/$1" ]] && return 0
      done
    fi

    return 1
  }

  _fzcd_unhandled_command() {
    [[ $# == 0 || $1 == -* ]]
  }

  _fzcd_run_fzf() {
    # shellcheck disable=SC2145
    declare -a opts=(--query="$@" --bind="del:execute-silent(fuzzycd -d {})+reload(fuzzycd -s)" --select-1 --exit-0 --info=hidden --prompt="$ cd ")

    case "$FUZZYCD_MODE" in
      # p = interactive with preview
      "p")
        fzf "${opts[@]}" --preview='ls {}' --preview-window="border-left"
        ;;

      # i = interactive, no preview
      "i")
        fzf "${opts[@]}"
        ;;

      # m = minimal, non interactive (default)
      *)
        fzf --filter "$@" --exit-0 | head -1
        ;;

    esac
  }

  _fzcd_dir_search() {
    _fzcd_run_fzf "$@" <"$histfile"
  }

  _fzcd_remember_me() {
    grep -qxF "$PWD" "$histfile" || echo "$PWD" >>"$histfile"
  }

  _fzcd_create_histfile() {
    mkdir -p "$(dirname "$histfile")" && touch "$histfile"
  }

  _fzcd_chdir() {
    builtin cd "$@" && _fzcd_remember_me
  }

  _fzcd_chdir_fzf() {
    target=$(_fzcd_dir_search "$@")
    if [[ -n $target ]]; then
      if [[ -d "$target" ]]; then
        _fzcd_chdir "$target"
        echo "$target"
      else
        echo "directory gone" >&2
        _fzcd_delete_dir "$target" >&2
        return 1
      fi
    elif [[ -n "$1" ]]; then
      _fzcd_chdir "$@"
    fi
  }

  _fzcd_edit_histfile() {
    "${EDITOR:-cat}" "$histfile"
  }

  _fzcd_show_histfile() {
    cat "$histfile"
  }

  _fzcd_show_version() {
    echo "fuzzycd $version"
  }

  _fzcd_delete_dir() {
    dir="${1:-$PWD}"
    grep -Fxv "$dir" "$histfile" >"$HOME/.fuzzycd-history.tmp"
    cp "$HOME/.fuzzycd-history.tmp" "$histfile"
    rm -f "$HOME/.fuzzycd-history.tmp"
    echo "deleted $dir"
  }

  _fzcd_show_usage() {
    _fzcd_show_version
    echo ""
    echo "Usage:"
    echo "  cd DIR       change working directory"
    echo "  cd SEARCH    change working directory or show selection menu"
    echo "  cd -l        list history with fzf"
    echo "  cd -e        edit history file"
    echo "  cd -s        show history file"
    echo "  cd -d [DIR]  delete current or specified directory from history"
    echo "  cd -c        show completions function [usage: eval \"\$(cd -c)\"]"
    echo "  cd -v        show version"
    echo "  cd -h        show this help"
    echo ""
    echo "Environment Variables:"
    echo "  FUZZYCD_HISTORY_FILE"
    echo "    Path to history file (default: ~/.fuzzycd-history)"
    echo ""
    echo "  FUZZYCD_MODE"
    echo "    Set operation mode (one of: m, i, p)"
    echo "      m = minimal, non interactive, always cd to best match (default)"
    echo "      i = interactive when needed, no preview"
    echo "      p = interactive when needed, with ls preview"
    echo ""
    echo "  FUZZYCD_COMPLETIONS_COUNT"
    echo "    Maximum number of suggestions to show in bash completions"
    echo "    (default: 10)"
    echo ""
    echo "Interactive Keyboard Bindings:"
    echo "  Del"
    echo "    Delete selected directory from history"
  }

  # shellcheck disable=SC2016
  _fzcd_show_completions() {
    echo '_fuzzycd_completions() {'
    echo '  local cur=${COMP_WORDS[COMP_CWORD]}'
    echo '  local histfile=${FUZZYCD_HISTORY_FILE:-"$HOME/.fuzzycd-history"}'
    echo '  local count=${FUZZYCD_COMPLETIONS_COUNT:-10}'
    echo '  _cd' # invoke original completions
    echo '  [[ $cur =~ ^(/|\.) ]] && return'
    echo '  COMPREPLY+=( $(fzf --filter "$cur" --exit-0 <"$histfile" | head -n$count) )'
    echo '}'
    echo 'complete -o nosort -F _fuzzycd_completions cd'
  }

  _fzcd_handle_command() {
    if _fzcd_unhandled_command "$@"; then
      _fzcd_chdir "$@"
    elif _fzcd_is_dirname "$1"; then
      _fzcd_chdir "$1"
    else
      _fzcd_chdir_fzf "$@"
    fi
  }

  _fzcd_run() {
    [[ -f "$histfile" ]] || _fzcd_create_histfile

    case "$1" in
      "-l") FUZZYCD_MODE=i _fzcd_chdir_fzf ;;
      "-v") _fzcd_show_version ;;
      "-e") _fzcd_edit_histfile ;;
      "-s") _fzcd_show_histfile ;;
      "-c") _fzcd_show_completions ;;
      "-d")
        shift
        _fzcd_delete_dir "$@"
        ;;
      "-h") _fzcd_show_usage ;;
      *) _fzcd_handle_command "$@" ;;
    esac
  }

  _fzcd_run "$@"
}

# shellcheck disable=SC2015
(return 0 2>/dev/null) && is_sourced=1 || fuzzycd_run "$@"

if [[ -n "$is_sourced" ]]; then
  # If not running interactively, don't do anything
  # Bypass by setting FUZZYCD_TTY_FORCE
  if [[ -z "$FUZZYCD_TTY_FORCE" ]]; then
    case $- in
      *i*) ;;
      *) return ;;
    esac
  fi

  unalias cd 2>/dev/null || true
  cd() {
    fuzzycd_run "$@"
  }
fi
