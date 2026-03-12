# AGENTS.md

## Scope

These notes apply to work inside this repository.

## Testing Rules

- Keep using the existing approval-test style in `test/approve` unless there is a strong reason to introduce a different layer of testing.
- Never edit approval fixtures in `test/approvals` manually.
- If behavior changes intentionally, run the approval flow and let a human approve fixture updates.
- Prefer adding direct assertions in `test/approve` when a regression can be covered without changing fixtures.

## Repo Utilities

- Useful repo commands are defined in `op.conf`.
- Run them as `op COMMAND`.
- Current commands include `op shellcheck`, `op shfmt`, `op codespell`, and `op test`.

## Working Notes

- Preserve the existing shell style and test conventions.
- If temporary files or directories are needed, use `./tmp` only.
- Do not create temporary folders outside `./tmp`.
- Approval tests may need a temporary writable `HOME` in constrained environments; if so, place it under `./tmp`.
- Completed so far: TODO item 1, making `cd -d` respect `FUZZYCD_HISTORY_FILE` and avoid the fixed `$HOME` temp file.
