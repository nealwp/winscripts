param (
    [string]$action
)

switch ($action) {
    "list" {
        Get-ChildItem $PSScriptRoot | ForEach-Object {$_.BaseName} | Write-Host
    }
    Default {
        "Error: argument '$action' not recognized."
        exit
    }
}