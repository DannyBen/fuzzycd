# Fuzzy CD

![Version](https://img.shields.io/badge/version-0.1.2-blue.svg)
[![Build Status](https://github.com/DannyBen/fuzzy-cd/workflows/Test/badge.svg)](https://github.com/DannyBen/fuzzy-cd/actions?query=workflow%3ATest)

A bash function that patches the native `cd` to allow changing directories
instantly using a fuzzy search.

![](/demo/cast.gif)

## Features

- Preserves the native `cd` completion.
- Understands `CDPATH`.
- Remembers all visited directories.
- Allows changing directory to any directory from the history that matches the
  input fuzzy search (unless it matches an actual directory).
- Shows available choices, with `ls` preview, when there are more than one
  matches.
- Does not override the builtin `cd` when running non-interactively.
- Adds `cd -l` flag, to show the entire history with `ls` preview.


## Prerequisites

Fuzzy CD requires a recent version of [fzf].


## Installation

### Installing using the setup script

This setup script will download the `fuzzy-cd` function to `~/.fuzzy-cd/` and
apply the necessary `source` command to your startup script.

```shell
$ curl -Ls get.dannyb.co/fuzzy-cd/setup | bash
```

You are encouraged to inspect the [setup script](setup) before running.

### Installing manually

1. Place the `fuzzy-cd` file somewhere on your system (for example: `~/.fuzzy-cd/fuzzy-cd`)
2. Source it (`source ~/.fuzzy-cd/fuzzy-cd`) from your startup script (for example: `~/.bashrc`)


## Usage


First, verify that Fuzzy CD is properly installed by running:

```shell
$ cd -h
```

Now, you can use `cd` normally to change to any directory. These directories
will be remembered in a history file. You can view this file by running:

```shell
$ cat ~/.fuzzy-cd-history
```

### Fuzzy search

Use `cd` with a string that is *not* a directory. If exactly one directory in
the history matches this string, you will instantly `cd` to it as usual.

If more than one directories match, you will be prompted to choose one of the
matching directories.
    

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

[issues]: https://github.com/DannyBen/fuzzy-cd/issues
[fzf]: https://github.com/junegunn/fzf
