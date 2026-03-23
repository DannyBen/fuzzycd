<div align='center'>
<img src='logo/logo-full.png' width=280>

A bash function that patches the native `cd` to allow changing directories
instantly using a fuzzy match, with or without an interactive menu.

![](/demo/cast.gif)

</div>

# Fuzzy CD

![repocard](https://repocard.dannyben.com/svg/fuzzycd.svg)

## Features

- Preserves the native `cd` completion.
- Understands `CDPATH`.
- Remembers all visited directories.
- Allows changing directory to any directory from the history that matches the
  input fuzzy search (unless it matches an actual directory).
- Shows available choices with `ls` preview, when there are more than one
  matches (optional).
- Does not override the builtin `cd` when running non-interactively.
- Adds flags such as `cd -l` to view and manage the history.
- Three operation modes:
  - Minimal - cd to best match
  - Interactive
  - Interactive with `ls` preview
- Optional bash completions that prefer native `cd` matches before fuzzy history.

## Prerequisites

Fuzzy CD requires a recent version of [fzf].


## Installation

### Installing using the setup script

Use the [setup](setup) script for automatic installation. It installs
`fuzzycd` and adds the required shell startup hook.

```shell
$ curl -Ls get.dannyb.co/fuzzycd/setup | bash
```

### Installing manually

1. Place the `fuzzycd` file somewhere on your `PATH` and make it executable.
2. Source it from your startup script (for example: `source /usr/local/bin/fuzzycd` in `~/.bashrc`).


## Usage


<details>
  <summary>Show Usage Patterns</summary>

  ```
  $ cd -h
  Usage:
    cd DIR       change working directory
    cd SEARCH    change working directory or show selection menu
    cd -l        list history with fzf
    cd -e        edit history file
    cd -s        show history file
    cd -p        prune non-existent directories from history
    cd -d [DIR]  delete current or specified directory from history
    cd -c        show completions function [usage: eval "$(cd -c)"]
    cd -v        show version
    cd -h        show this help

  Environment Variables:
    FUZZYCD_HISTORY_FILE
      Path to history file (default: ~/.fuzzycd-history)

    FUZZYCD_MODE
      Set operation mode (one of: m, i, p)
        m = minimal, non interactive, always cd to best match (default)
        i = interactive when needed, no preview
        p = interactive when needed, with ls preview

    FUZZYCD_COMPLETIONS_COUNT
      Maximum number of suggestions to show in bash completions
      (default: 10)

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
matching directories when running in interactive mode, or you will
`cd` to the best match when running in non-interactive mode (default).


## Bash completions

If you install using the [`setup`](setup) script, fuzzy bash completions are
enabled automatically for Bash.

If you install manually, add the following line to your `~/.bashrc`:

```bash
eval "$(fuzzycd -c)"
```

These completions keep Bash's native `cd` matches first and then append fuzzy
history matches without duplicates.

This works best when tab completion is configured for inline completions, which
you can set by adding/updating the `~/.inputrc` file:

```bash
# ~/.inputrc
TAB: menu-complete
```

## Uninstall

Use the uninstall script for automatic removal:

```shell
$ curl -Ls get.dannyb.co/fuzzycd/uninstall | bash
```

Or remove it manually:

1. Remove the line that sources `fuzzycd` from your startup script.
2. Remove the `eval "$(fuzzycd -c)"` line from your startup script, if you added it manually.
3. Delete the `fuzzycd` executable from your `PATH`.
4. Optionally, delete the history file (`~/.fuzzycd-history`).
5. Restart your session.


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

Tests are split into two layers:

- `test/approve` keeps exact-output approval coverage and low-level shell assertions.
- `features/` contains Shellkin acceptance scenarios for the main user-facing flows.

Run them with `op test`, or run the acceptance layer alone with `op acceptance`.

---

<table>
  <tr><td align="center" colspan="4"><strong>This repository is part of the Bash Productivity Suite</strong></td></tr>
  <tr>
    <td><a href="https://github.com/dannyben/alf"><img src="https://github.dannyben.com/assets/img/alf.png"></a></td>
    <td><a href="https://github.com/dannyben/opcode"><img src="https://github.dannyben.com/assets/img/opcode.png"></a></td>
    <td><a href="https://github.com/dannyben/fuzzycd"><img src="https://github.dannyben.com/assets/img/fuzzycd.png"></a></td>
    <td><a href="https://github.com/dannyben/rush"><img src="https://github.dannyben.com/assets/img/rush.png"></a></td>
  </tr>
</table>

---

[issues]: https://github.com/DannyBen/fuzzycd/issues
[fzf]: https://github.com/junegunn/fzf
