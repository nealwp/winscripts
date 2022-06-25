Import-Module $PSScriptRoot/modules/Get-IniFile.psm1

$ini = Get-IniFile $PSScriptRoot/config/winscripts.ini
$drive = $ini.default.drive

Start-Process code $drive/source/provenpci.com/backend
Start-Process code $drive/source/provenpci.com/frontend
