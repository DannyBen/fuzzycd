; --------------------------------------------------
; This script generates the demo gif
; --------------------------------------------------
#SingleInstance Force

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

  SetkeyDelay 0, 50

  Type("cd -h |most")
  Sleep 300
  SetKeyDelay 200
  Send {Down 14}
  SetkeyDelay 0, 50
  Sleep 1000
  Send q

  Type("{#} Visiting directories adds them to history")
  Type("cd test")
  Type("cd approvals")
  Type("cd ../../demo")
  
  Type("{#} Now cd also changes to the best matching directory")
  Type("cd tst")

  Type("{#} Enable interactive mode by setting FUZZYCD_MODE")
  Type("export FUZZYCD_MODE=i")
  Type("cd fzy")
  SetKeyDelay 700
  Send {Up}{Up}{Down}{Enter}
  SetkeyDelay 0, 50
  
  Type("cd ..")
  Type("{#} The menu is not shown when there is only one match")
  Type("cd app")
  Type("cd ../../")

  Type("exit")
  Type("unset FUZZYCD_HISTORY_FILE")
  Type("unset FUZZYCD_MODE")
  Type("agg --font-size 20 demo/cast.json demo/cast.gif")
  Type("{#} DONE")
Return

^F12::
  Reload
return

ESC::
  ExitApp
return
