Import-Module $PSScriptRoot/modules/Get-IniFile.psm1

$ini = Get-IniFile $PSScriptRoot/config/winscripts.ini
$xpath = $ini.path.notepad

Start-Process $xpath