export APPROVALS_DIR="$PWD/approvals"
source approvals.bash

context_string="\n$(bold "%s")"
describe_string="  %s"
it_string="    %s"
fail_string="      $(red "✗ %s")"
pass_string="      $(green "✓ %s")"
exit_success_string="\n$(green_bold "%s finished successfully")"
exit_failed_string="$(red_bold "%s finished with errors")"

basedir="$PWD"
source ../fuzzycd
export FUZZYCD_HISTORY_FILE="$PWD/tmp/histfile"
rm -f "$FUZZYCD_HISTORY_FILE"
mkdir -p tmp/one/two
mkdir -p "$HOME/.fuzzycd"
