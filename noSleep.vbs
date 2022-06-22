set wsc = CreateObject("WScript.Shell")
WScript.Echo("Removing sleep-cycle requirement...")
Do
    WScript.Sleep(3*60*1000)
    wsc.SendKeys("{F13}")
    WScript.Echo("You're now feeling well-rested.")
Loop
