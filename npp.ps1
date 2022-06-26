Import-Module $PSScriptRoot/modules/Get-IniFile.psm1

$ini = Get-IniFile $PSScriptRoot/config/winscripts.ini
$drive = $ini.default.drive

Start-Process "$drive\Program Files\Notepad++\notepad++.exe"