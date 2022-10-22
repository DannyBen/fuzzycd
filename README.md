<div align='center'>
<img src='logo/logo-full.png' width=280>

A bash function that patches the native `cd` to allow changing directories
instantly using a fuzzy search

![](/demo/cast.gif)

</div>

# Fuzzy CD

![Version](https://img.shields.io/badge/version-0.2.0-blue.svg)
[![Build Status](https://github.com/DannyBen/fuzzycd/workflows/Test/badge.svg)](https://github.com/DannyBen/fuzzycd/actions?query=workflow%3ATest)

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

This setup script will download the `fuzzycd` function to `/usr/local/bin` and
apply the necessary `source` command to your startup script.

```shell
$ curl -Ls get.dannyb.co/fuzzycd/setup | bash
```

You are encouraged to inspect the [setup script](setup) before running.

### Installing manually

1. Place the `fuzzycd` file in `/usr/local/bin/` and make it executable
2. Source it (`source /usr/local/bin/fuzzycd`) from your startup script (for example: `~/.bashrc`)


## Usage


<details>
  <summary>Show Usage Patterns</summary>

  ```
  $ cd -h

  fuzzycd 0.2.0

  Usage:
    cd DIR       change working directory
    cd SEARCH    change working directory or show selection menu
    cd -l        list history with fzf
    cd -e        edit history file
    cd -s        show history file
    cd -d [DIR]  delete current or specified directory from history
    cd -v        show version
    cd -h        show this help

  Environment Variables:
    FUZZYCD_HISTORY_FILE
      Path to history file (default: ~/.fuzzycd-history)

    FUZZYCD_MODE
      Set operation mode (one of: m, i, p)
        m = minimal, non interactive, always cd to best match
        i = interactive when needed, no preview
        p = interactive when needed, with ls preview (default)

  Interactive Keyboard Bindings:
    Del
      Delete selected directory from history
  ```

</details>

---


First, verify that Fuzzy CD is properly installed by running:

```shell
$ cd -h
```

Now, you can use `cd` normally to change to any directory. These directories
will be remembered in a history file. You can view this file by running:

```shell
$ cd -s
# or
$ cat ~/.fuzzycd-history
```

### Fuzzy search

Use `cd` with a string that is *not* a directory. If exactly one directory in
the history matches this string, you will instantly `cd` to it as usual.

If more than one directories match, you will be prompted to choose one of the
matching directories when running in interactive mode (default), or you will
`cd` to the best match when running in non-interactive mode.


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

[issues]: https://github.com/DannyBen/fuzzycd/issues
[fzf]: https://github.com/junegunn/fzf
