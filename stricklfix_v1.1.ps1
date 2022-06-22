Function Get-FileName($initialDirectory)
{ [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |
Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "Text files (*.txt)| *.txt"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName


$file = Get-FileName -initialDirectory "C:\Users\$env:UserName\Desktop"
$file_content = Get-Content -Path $file

foreach ($line in $file_content) {
    if ($line.Length -gt 0) {
        $uic_name = $line.Substring(6, 6)
        break
        }
}

$date = (Get-Date -UFormat "%m-%d") 

$file_out_name = $uic_name + "_" + $date + "_fx.txt" 
$output_filepath = "C:\Users\$env:UserName\Desktop\$file_out_name"


if ([System.IO.File]::Exists($output_filepath)) {
    Remove-Item $output_filepath
    }  

"`r`n" * 6 | Out-File $output_filepath -Append

foreach ($line in $file_content) {
    if ($line.Length -gt 0 -And $line.Substring(12, 4) -like "* *") {
        $number_of_spaces = ($line.Substring(12, 4).ToCharArray() | Where-Object {$_ -eq " "} | Measure-Object).Count
        $inverse_number_of_spaces = 4 - $number_of_spaces
        $day_number = ($line.Substring(12, 4)).SubString(0,  $inverse_number_of_spaces)
        $zeroes = "0" *  $number_of_spaces
        $fixed_julian_date = $zeroes + $day_number
        #$fixed_line =  $line -replace $line.SubString(12, 4), $fixed_julian_date
        $fixed_line = $line.Substring(0, 12) + $fixed_julian_date + $line.Substring(16, (($line.Length) - 16))
        $fixed_line + "`r`n" | Out-File $output_filepath -Append
        }
        ElseIf ($line.Length -gt 0 -And $line.Substring(12, 4) -notlike "* *") {
            $line + "`r`n" | Out-File $output_filepath -Append
        }
    }

"`r`n" * 5 | Out-File $output_filepath -Append