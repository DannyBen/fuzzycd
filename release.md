---
runpage:
  required: [version]
  dependencies: [git, curl]
  workdir: self
---

# fuzzycd release checklist

Release verification for fuzzycd. Run this document with
[runpage](https://github.com/DannyBen/runpage):

```console :noop
runpage release.md version:0.3.1
```

## Git is on master and clean

```bash :check
test "$(git branch --show-current)" = master && test -z "$(git status --porcelain)"
```

## Generated executable has the release version

```bash :check
test "$(./fuzzycd -v)" = "fuzzycd {{ version }}"
```

## Local release tag exists

```bash :check
git rev-parse --quiet --verify "refs/tags/v{{ version }}" >/dev/null
```

## Changelog contains the release

```bash :check
grep -Fq "v{{ version }}" CHANGELOG.md
```

## GitHub tag exists

```bash :check
curl -fsS -o /dev/null "https://github.com/DannyBen/fuzzycd/tree/v{{ version }}"
```

## GitHub latest release points to the version

```bash :check
location=$(
  curl -fsSI https://github.com/DannyBen/fuzzycd/releases/latest |
    tr -d '\r' |
    awk 'tolower($1) == "location:" { print $2 }' |
    tail -n 1
)
test "$location" = "https://github.com/DannyBen/fuzzycd/releases/tag/v{{ version }}"
```

## GitHub release executable is available

```bash :check
curl -fsSI -o /dev/null "https://github.com/DannyBen/fuzzycd/releases/download/v{{ version }}/fuzzycd"
```
