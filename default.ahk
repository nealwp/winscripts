#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
:::cv::COVID SCREEN QUESTIONAIRE COMPLETE: 'No' to all questions
:::nr::Neal / Remote
:::ns::Neal / Summary
:::nf::not a finding.
:::fsmail::william.p.neal36.ctr@us.navy.mil
:::rdmail::william.neal.ctr@niwc.navy.mil

; Daily ISS Email
+!d::
WinActivate, ahk_exe outlook.exe
Send, {Ctrl down}n{Ctrl up}
Send, covid-sysad@issits.com; 
Send, {Alt down}u{Alt up}
Send, Neal / Remote
Send, {Enter down}{Enter up}
Send, {Ctrl down}a{Ctrl up}
Send, {Delete}
Send, COVID SCREEN QUESTIONAIRE COMPLETE: 'No' to all questions

