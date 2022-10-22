; --------------------------------------------------
; This script generates the demo gif
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

; NOTES TO SELF:
;
;   1. ESC == EMERGENCY ABORT
;   2. Starting point should be the root fuzzycd directory
;   3. This is the prompt we are using. Put it in ~/.bashrc.d/prompt.bashrc
;      PS1="\n\[\e[0;35m\]\h \[\e[1;34m\]\w \[\e[1;32m\]➜\[\e[0m\] "
;   4. Recorded in a half tmux panel
;

Outfile := "cast.svg"
Template := "window_frame"

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("export FUZZYCD_HISTORY_FILE=/tmp/history")
  Type("rm -f /tmp/history")
  Type("rm demo/cast.json {;} asciinema rec demo/cast.json")

  Type("cd -h")
  Type("{#} First, we visit directories to add to history")
  Type("cd test")
  Type("cd approvals")
  Type("cd ../../demo")
  Type("cd")
  Type("{#} Now we can cd using fuzzy search")
  
  Type("{#} When there are multiple matches, we are prompted to choose")
  Type("cd fzy")
  SetKeyDelay 700
  Send {Up}{Up}{Down}{Enter}
  SetkeyDelay 0, 50
  
  Type("cd")
  Type("{#} When there is only one match, it is used instantly")
  Type("cd fupp")
  Type("cd ../../")

  Type("{#} End of transmission")

  Type("exit")
  Type("unset FUZZYCD_HISTORY_FILE")
  ; Type("cat demo/cast.json | svg-term --out demo/cast.svg --window")
  Type("agg --font-size 20 demo/cast.json demo/cast.gif")
  Type("{#} DONE")
Return

^F12::
  Reload
return

ESC::
  ExitApp
return
