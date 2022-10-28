Change Log
========================================

v0.2.2 - 2022-10-28
----------------------------------------

- Fix CDPATH recognition
- Fix automatic delete from history to not exit


v0.2.1 - 2022-10-25
----------------------------------------

- Fix 'cd -l' when FUZZYCD_MODE=non-interactive
- Update FUZZYCD_MODE to a single letter: [m]inimal, [i]nteractive or [p]review
- Automatically delete directories that no longer exist on cd


v0.2.0 - 2022-10-22
----------------------------------------

- Change history file location to ~/.fuzzy-cd/history
- Add 'cd -d [DIR]' to delete from history
- Display environment variables in 'cd -h'
- Add two more fzf modes: non-interactive and no-preview
- Major refactor


v0.1.2 - 2022-10-22
----------------------------------------

- Add more flags (cd -h to see)
- Fix context contamination


v0.1.0 - 2022-10-21
----------------------------------------

- Initial version


