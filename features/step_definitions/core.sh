@Given a fresh fuzzycd workspace
  create_workspace "core"

@Given the directory '{path}' exists
  mkdir -p "$(workspace_path "$path")"

@Given I have visited '{path}'
  target=$(workspace_path "$path")
  mkdir -p "$target"
  cd "$target" || fail "Could not cd to $target"
  cd "$WORKSPACE" || fail "Could not return to workspace root"

@Given the history file contains '{path}'
  printf '%s\n' "$(workspace_path "$path")" >> "$FUZZYCD_HISTORY_FILE"

@Given I am in the workspace root
  cd "$WORKSPACE" || fail "Could not cd to workspace root"

@When I run '{command}'
  run_in_current_shell "$command"

@Then the exit code should be '{code}'
  [[ "$LAST_EXIT_CODE" == "$code" ]] || fail "Expected exit code $code, got $LAST_EXIT_CODE"

@Then stdout should include '{text}'
  [[ "$LAST_STDOUT" == *"$text"* ]] || fail "Expected stdout to include: $text"

@Then stderr should be empty
  [[ -z "$LAST_STDERR" ]] || fail "Expected empty stderr, got: $LAST_STDERR"

@Then the current directory should be '{path}'
  expected=$(workspace_path "$path")
  [[ "$PWD" == "$expected" ]] || fail "Expected PWD $expected, got $PWD"

@Then the history file should contain '{path}'
  expected=$(workspace_path "$path")
  grep -Fx "$expected" "$FUZZYCD_HISTORY_FILE" >/dev/null || fail "Expected history to contain $expected"

@Then the history file should not contain '{path}'
  expected=$(workspace_path "$path")
  ! grep -Fx "$expected" "$FUZZYCD_HISTORY_FILE" >/dev/null || fail "Expected history to omit $expected"
