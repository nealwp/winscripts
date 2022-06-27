param (
    [string]$query
)
$query = $query.replace(' ', '+')
Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" "www.google.com/search?q=$query"