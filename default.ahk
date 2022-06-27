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
:::omail::mrprestonneal@outlook.com
:::gmail::mrprestonneal@gmail.com

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
return

; change text casing
+!u::  ; Shift-Alt-u UPPERCASE
Clipboard = ; Empty the clipboard so that ClipWait has something to detect
SendInput, ^c ;copies selected text
ClipWait
StringReplace, OutputText, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
StringUpper, OutputText, OutputText
SendRaw % OutputText
VarSetCapacity(OutputText, 0)                                                                  
return

+!l:: ; Shift-Alt-l lowercase
Clipboard = 
SendInput, ^c 
ClipWait
StringReplace, OutputText, Clipboard, `r`n, `n, All 
StringLower, OutputText, OutputText
SendRaw % OutputText
VarSetCapacity(OutputText, 0)
return

+!k:: ; Shift-Alt-k Titlecase                                                               
Clipboard = 
SendInput, ^c 
ClipWait
StringReplace, OutputText, Clipboard, `r`n, `n, All  
StringUpper, OutputText, OutputText, T
SendRaw % OutputText
VarSetCapacity(OutputText, 0) 
return
