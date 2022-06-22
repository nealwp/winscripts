#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
#  Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
#  exit;
#}

$winscriptspath = Get-Location

if ($env:Path.Contains($winscriptspath)){
  Write-Host "PATH entry already exists. No changes made"
  exit
}

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$winscriptspath", "User")

Write-Host "winscripts directory added to Path. Please restart your terminal."