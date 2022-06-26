; "CTRL + Alt + S" for Launching spotify / Activating the window / Minimizing the window
#NoEnv
EnvGet, username, username
^!S::
IfWinExist ahk_exe Spotify.exe
{
	ifWinActive ahk_exe Spotify.exe
	{
		WinMinimize
	}
	else
	{
		WinActivate
	}
}
else
{
    path := "C:\Users\" username "\AppData\Roaming\Spotify\Spotify.exe"
	run %path%
}
return

TellSpotify(name) {
    
    Command := { "TogglePlay": "{Space}", "Next": "^{right}", "Previous": "^{left}" }

    cmd := Command[name]

    ifWinActive ahk_exe Spotify.exe 
    {
        Send, %cmd%
        WinMinimize ahk_exe Spotify.exe
    } else 
    {
        WinActivate ahk_exe Spotify.exe
        Send, %cmd%
        WinMinimize ahk_exe Spotify.exe
    }
    return
}

^!Space::
TellSpotify("TogglePlay")
return

^!Right::
TellSpotify("Next")
return

^!Left::
TellSpotify("Previous")
return