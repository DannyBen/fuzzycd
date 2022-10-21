# Fuzzy CD

A bash function that patches the native `cd` to allow changing directories
instantly using a fuzzy search.

## Features

- Preserves the native `cd` completion.
- Understands `CDPATH`.
- Remembers all visited directories.
- Allows changing directory to any directory from the history that matches the
  input fuzzy search (unless it matches an actual directory).
- Shows available choices, with `ls` preview, when there are more than one
  matches.
- Adds `cd -l` flag, to show the entire history with `ls` preview.

## Prerequisites

Fuzzy CD requires [fzf].

## Install

1. Place the `fuzzy-cd` file somewhere on your system (for example: `~/.fuzzy-cd/fuzzy-cd`)
2. Source it (`source ~/.fuzzy-cd/fuzzy-cd`) from your initialization script (for example: `~/.bashrc`)
    


[fzf]: https://github.com/junegunn/fzf
