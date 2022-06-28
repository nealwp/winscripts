param (
    [string]$query
)
$query = $query.replace(' ', '+')
if ($query) {
    Start-Process "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "www.google.com/search?q=$query"
    exit
}
Start-Process "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"