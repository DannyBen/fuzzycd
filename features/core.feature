Feature: core fuzzycd flows
  Acceptance coverage for the main fuzzycd flows.

Background:
  Given a fresh fuzzycd workspace

Scenario: Show help
  When I run 'cd -h'
  Then the exit code should be '0'
  And stdout should include 'Usage:'
  And stdout should include 'cd -c'
  And stderr should be empty

Scenario: Show completions function
  When I run 'cd -c'
  Then the exit code should be '0'
  And stdout should include 'complete -o nosort -F _fuzzycd_completions cd'
  And stderr should be empty

Scenario: Explicit cd adds the visited directory to history
  Given the directory 'alpha/beta' exists
  When I run 'cd alpha/beta'
  Then the exit code should be '0'
  And the current directory should be 'alpha/beta'
  And the history file should contain 'alpha/beta'

Scenario: Fuzzy search changes to a matching directory from history
  Given I have visited 'one/two'
  And I am in the workspace root
  When I run 'cd ontwo'
  Then the exit code should be '0'
  And the current directory should be 'one/two'
  And stderr should be empty

Scenario: Show history file
  Given I have visited 'one/two'
  And I have visited 'dev'
  When I run 'cd -s'
  Then the exit code should be '0'
  And stdout should include '/one/two'
  And stdout should include '/dev'
  And stderr should be empty

Scenario: Delete a directory from history
  Given I have visited 'one/two'
  And I have visited 'dev'
  When I run 'cd -d "$WORKSPACE/dev"'
  Then the exit code should be '0'
  And stdout should include 'deleted'
  And the history file should contain 'one/two'
  And the history file should not contain 'dev'

Scenario: Prune missing history entries
  Given the directory 'keep/me' exists
  And the history file contains 'keep/me'
  And the history file contains 'gone/dir'
  When I run 'cd -p'
  Then the exit code should be '0'
  And stdout should include 'pruned'
  And the history file should contain 'keep/me'
  And the history file should not contain 'gone/dir'
