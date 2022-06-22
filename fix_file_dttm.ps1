$mypath = "C:\Users\william.neal\Desktop\neal-cyberm0000.pdf"
$date = "10/1/2019 7:46:01 am"
(Get-Item $mypath).LastWriteTime = (Get-Date $date)
(Get-Item $mypath).CreationTime = (Get-Date $date)
(Get-Item $mypath).LastAccessTime = (Get-Date $date)

Get-Item $mypath