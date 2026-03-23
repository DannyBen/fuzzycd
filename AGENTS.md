# AGENTS.md

## Scope

These notes apply to work inside this repository.

## Testing Rules

- Keep using the existing approval-test style in `test/approve` unless there is a strong reason to introduce a different layer of testing.
- Never edit approval fixtures in `test/approvals` manually.
- If behavior changes intentionally and a fixture update is needed, leave that to the human approval flow by running `test/approve`.
- If a test change causes an approval diff, keep the approval test in place, stop short of editing the fixture, and let the user run and approve it manually.
- Prefer adding direct assertions in `test/approve` when a regression can be covered without changing fixtures.

## Repo Utilities

- Useful repo commands are defined in `op.conf`.
- Run them as `op COMMAND`.
- Current commands include `op shellcheck`, `op shfmt`, `op codespell`, and `op test`.
- Preserve the existing shell style and test conventions.
- If temporary files or directories are needed, use `./tmp` only.
- Do not create temporary folders outside `./tmp`.
- Approval tests may need a temporary writable `HOME` in constrained environments; if so, place it under `./tmp`.
- Keep `cd -d` history rewrites tied to `FUZZYCD_HISTORY_FILE`; do not reintroduce fixed temp files under `$HOME`.
- Keep completion behavior aligned with this contract: native `cd` matches first, fuzzy history matches after, no duplicates, and preserve `cd` registration to `_fuzzycd_completions`.
- Installer behavior note: Bash completions may be installed automatically for Bash startup, but not for Zsh unless a native or explicitly supported compatibility path exists.
