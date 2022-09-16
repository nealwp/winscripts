param (
    [string]$query
)
$query = $query.replace(' ', '+')

Import-Module $PSScriptRoot/modules/Get-IniFile.psm1

$ini = Get-IniFile $PSScriptRoot/config/winscripts.ini
$xpath = $ini.path.chrome

if ($query) {
    Start-Process $xpath "www.google.com/search?q=$query"
    exit
}
Start-Process $xpath