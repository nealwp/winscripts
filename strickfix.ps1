Function Get-FileName($initialDirectory)
{  
 [System.Reflection.Assembly]::LoadWithPartialName(“System.windows.forms”) |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = “All files (*.*)| *.*”
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName


$file = Get-FileName -initialDirectory "C:\Users\$env:UserName\Desktop"
$output_filepath = "C:\Users\$env:UserName\Desktop\strickfix_output.txt"
$file_content = Get-Content -Path $file

if ([System.IO.File]::Exists($output_filepath)) {
    Remove-Item $output_filepath
    }  

foreach ($line in $file_content) {
    if ($line.Length -gt 0 -And $line.Substring(12, 4) -like "* *") {
        $number_of_spaces = ($line.Substring(12, 4).ToCharArray() | Where-Object {$_ -eq " "} | Measure-Object).Count
        $inverse_number_of_spaces = 4 - $number_of_spaces
        $day_number = ($line.Substring(12, 4)).SubString(0,  $inverse_number_of_spaces)
        $zeroes = "0" *  $number_of_spaces
        $fixed_julian_date = $zeroes + $day_number
        $fixed_line =  $line -replace $line.SubString(12, 4), $fixed_julian_date
        $fixed_line | Out-File $output_filepath -Append
        }
    }
