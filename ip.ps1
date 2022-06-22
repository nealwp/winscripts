(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.AddressState -eq "Preferred" -and $_.InterfaceAlias -like "Ethernet*"}).IPv4Address | Set-Clipboard
Write-Host "IP Address copied to clipboard"
