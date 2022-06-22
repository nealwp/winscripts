##########################################
### ASKIT UPLOAD EEBP FILE CORRECTION  ###
##########################################
#
# W Preston Neal
# william.p.neal.ctr@usmc.mil
# CACI, Inc.
# v1.2
# 1/24/2020
# 
# Corrects ASKIT upload fuel files downloaded from EEBP. Originally requested by GySgt James M. Strickland.
# 
# Fuel records in ASKIT upload files with a document Julian date since 1 January 2020 have 
# been generating without leading zeroes, e.g. "14" instead of "0014". This script takes the file
# downloaded from EEBP and pads the document Julian date with the appropriate number of zeroes, 
# outputting the corrected text as a new file.
#


# adds "File Explorer" functionality
Function Get-FileName($initialDirectory)
{ [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |
Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "Text files (*.txt)| *.txt"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} # end of function Get-FileName


# ask user to select "bad" text file
$file = Get-FileName -initialDirectory "C:\Users\$env:UserName\Desktop"
$file_content = Get-Content -Path $file

# find first ddsn UIC/DODAAC to use in output file name
foreach ($line in $file_content) {
    if ($line.Length -gt 0) {
        $uic_name = $line.Substring(6, 6)
        break
        }
}


# define options for output file name
$date = (Get-Date -UFormat "%m-%d") 
$file_out_name = $uic_name + "_" + $date + "_fx.txt" 
# $file_out_name = "corrected_eebp_file.txt"  # optional setting for a generic file name; note "delete if exists" below
$output_filepath = "C:\Users\$env:UserName\Desktop\$file_out_name"


# if output file already exists, delete to allow for new output file
if ([System.IO.File]::Exists($output_filepath)) {
    Remove-Item $output_filepath
    }  

"`r`n" * 6 | Out-File $output_filepath -Append


# pad missing zeroes
foreach ($line in $file_content) {
    if ($line.Length -gt 0 -And $line.Substring(12, 4) -like "* *") {
        $number_of_spaces = ($line.Substring(12, 4).ToCharArray() | Where-Object {$_ -eq " "} | Measure-Object).Count
        $inverse_number_of_spaces = 4 - $number_of_spaces
        $day_number = ($line.Substring(12, 4)).SubString(0,  $inverse_number_of_spaces)
        $zeroes = "0" *  $number_of_spaces
        $fixed_julian_date = $zeroes + $day_number
        $fixed_line = $line.Substring(0, 12) + $fixed_julian_date + $line.Substring(16, (($line.Length) - 16))
        $fixed_line + "`r`n" | Out-File $output_filepath -Append
        }
        ElseIf ($line.Length -gt 0 -And $line.Substring(12, 4) -notlike "* *") {
            $line + "`r`n" | Out-File $output_filepath -Append
        }
    }

"`r`n" * 5 | Out-File $output_filepath -Append