#######################################################
######  RSUPPLY/NALCOMIS FILE MAINTENACE SCRIPT  ######
#######################################################
#
# v1.0 -- 8/23/2019
#
# This script changes file names by RSupply/NALCOMIS batch job numbers and moves items to a new folder
## To use, run desired jobs in NALCOMIS and RSupply and Batch File Transfer them out of the application
## Do NOT change the destination folder on the Batch File Transfer screens. This script targets the default folder path.
## created by W Preston Neal for MALS-11

$ErrorActionPreference = 'SilentlyContinue' # hide error messages in command line window

$rsup_xfer = "C:\Users\$env:USERNAME\AppData\Roaming\ntcss\SUP1CL\xfer" # default folder path for RSupply Batch File Transfer 
$nalc_xfer = "C:\Users\$env:USERNAME\AppData\Roaming\ntcss\OIMACL\xfer" # default folder path for NALCOMIS File Transfer
$desktop = "C:\Users\$env:USERNAME\Desktop" # current user's Desktop

# Modify the "$sharedrive" link for your sharedrive dailies folder if required
## Ensure a server address is used (starts with "\\") 
## Do not use a sharedrive link that start with a drive letter! ("Z:\", "X:\") 
## Do not end the sharedrive link with a "\"
$sharedrive = "\\NENT95PNDLVS001\New_MAW_3rd\3MAW Shared Drive\MAG-11\MALS-11\02. Supply\ALL SUPPLY\Daily reports"

Write-Host "Current sharedrive path:" # user info prompt
Write-Host $sharedrive # user info prompt

$zz = "0" * (3-(Get-Date -UFormat %j).Length)
$dy = $zz + (Get-Date -UFormat %j).ToString() 
$longJDate = (Get-Date -UFormat %y) + $dy 
$JulianDate = $longJDate.Substring(1,4) # convert current date to Julian Date
$DateFolder = (Get-Date -UFormat "%d %b") # create a date name format for TIR folder

$rsupfilecount = [System.IO.Directory]::GetFiles("$rsup_xfer", "*").Count # count files in RSupply Xfer folder
Write-Host "Scanning $rsupfilecount file(s) in RSupply xfer folder..." # user info prompt

###########################################################
### RSupply Batch Job Numbers and associated file names ###
###########################################################

Get-ChildItem $rsup_xfer\JSS225*.* | Rename-Item -NewName { $_.name -Replace 'JSS225*.','SCRL_' }
Get-ChildItem $rsup_xfer\SCRL_* | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") } 

Get-ChildItem $rsup_xfer\JSL325*.* | Rename-Item -NewName { $_.name -Replace 'JSL325*.','Suspense_' }
Get-ChildItem $rsup_xfer\Suspense_* | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSL305*.* | Rename-Item -NewName { $_.name -Replace 'JSL305*.','Rescreen_' }
Get-ChildItem $rsup_xfer\Rescreen_* | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") } 

Get-ChildItem $rsup_xfer\JSS232*.* | Rename-Item -NewName { $_.name -Replace 'JSS232*.','StockDTORecon_' }
Get-ChildItem $rsup_xfer\StockDTORecon_* | Rename-Item -NewName {[io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSL311*.* | Rename-Item -NewName { $_.name -Replace 'JSL311*.','NoStat_' }
Get-ChildItem $rsup_xfer\NoStat_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSS220*.* | Rename-Item -NewName { $_.name -Replace 'JSS220*.','Incoming_' }
Get-ChildItem $rsup_xfer\Incoming_ | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSL319*.* | Rename-Item -NewName { $_.name -Replace 'JSL319*.','RSupOutgoing_' }
Get-ChildItem $rsup_xfer\RSupOutgoing_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI241*.* | Rename-Item -NewName { $_.name -Replace 'JSI241*.','PukListing_' }
Get-ChildItem $rsup_xfer\PukListing_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI242*.* | Rename-Item -NewName { $_.name -Replace 'JSI242*.','PukReport_' }
Get-ChildItem $rsup_xfer\PukReport_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI217*.* | Rename-Item -NewName { $_.name -Replace 'JSI217*.','SammaSal_' }
Get-ChildItem $rsup_xfer\SammaSal_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI215*.* | Rename-Item -NewName { $_.name -Replace 'JSI215*.','MSSR_' }
Get-ChildItem $rsup_xfer\MSSR_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI322*.* | Rename-Item -NewName { $_.name -Replace 'JSI322*.','MSSLL_' }
Get-ChildItem $rsup_xfer\MSSLL_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI221*.* | Rename-Item -NewName { $_.name -Replace 'JSI221*.','GainsLosses_' }
Get-ChildItem $rsup_xfer\GainsLosses_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSI222*.* | Rename-Item -NewName { $_.name -Replace 'JSI222*.','Surveys_' }
Get-ChildItem $rsup_xfer\Surveys_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $rsup_xfer\JSS233*.* | Rename-Item -NewName { $_.name -Replace 'JSS233*.','IssuesPendingRecon_' }
Get-ChildItem $rsup_xfer\IssuesPendingRecon_ | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

$dlmsfilecount = [System.IO.Directory]::GetFiles("$rsup_xfer", "DLMS*").Count  # count XML header files
Write-Host "Deleting $dlmsfilecount unnecessary file(s)..." # user info prompt
Remove-Item -Path $rsup_xfer\DLMS* # delete the XML header files that are produced by status release files

Get-ChildItem $rsup_xfer\J*.* | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") } # change any remaining RSupply batch file to .txt

$nalcfilecount = [System.IO.Directory]::GetFiles("$nalc_xfer", "*").Count # count files in NALCOMIS Xfer folder
Write-Host "Scanning $nalcfilecount file(s) in NALCOMIS xfer folder..." # user info prompt

##############################################################
###  NALCOMIS Batch Job Numbers and Associated File Names  ###
##############################################################

Get-ChildItem $nalc_xfer\J60660*.* | Rename-Item -NewName { $_.name -Replace 'J60660*.','NSNDataExceptions_' }
Get-ChildItem $nalc_xfer\NSNDataExceptions_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60630*.* | Rename-Item -NewName { $_.name -Replace 'J60630*.','NALC_SupplyQuantitiesModified_' }
Get-ChildItem $nalc_xfer\NALC_SupplyQuantitiesModified_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60600*.* | Rename-Item -NewName { $_.name -Replace 'J60600*.','NIINIndicativeUpdates_' }
Get-ChildItem $nalc_xfer\NIINIndicativeUpdates_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60635*.* | Rename-Item -NewName { $_.name -Replace 'J60635*.','NALC_SupplyDataDifferences_' }
Get-ChildItem $nalc_xfer\NALC_SupplyDataDifferences_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60650*.* | Rename-Item -NewName { $_.name -Replace 'J60650*.','NIINAnalysisReports_' }
Get-ChildItem $nalc_xfer\NIINAnalysisReports_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60690*.* | Rename-Item -NewName { $_.name -Replace 'J60690*.','NIINDupLocsReport_' }
Get-ChildItem $nalc_xfer\NIINDupLocsReport_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60665*.* | Rename-Item -NewName { $_.name -Replace 'J60665*.','NALC_SupplyPukDifferences_' }
Get-ChildItem $nalc_xfer\NALC_SupplyPukDifferences_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60690*.* | Rename-Item -NewName { $_.name -Replace 'J60690*.','NIINDupLocsReport_' }
Get-ChildItem $nalc_xfer\NIINDupLocsReport_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60640*.* | Rename-Item -NewName { $_.name -Replace 'J60640*.','NALC_SupplyStockDue_' }
Get-ChildItem $nalc_xfer\NALC_SupplyStockDue_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60681*.* | Rename-Item -NewName { $_.name -Replace 'J60681*.','DTODue_Exceptions_' }
Get-ChildItem $nalc_xfer\DTODue_Exceptions_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60680*.* | Rename-Item -NewName { $_.name -Replace 'J60680*.','NALC_SupplyDTODifferences_' }
Get-ChildItem $nalc_xfer\NALC_SupplyDTODifferences_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60710*.* | Rename-Item -NewName { $_.name -Replace 'J60710*.','DIFMRecon_' }
Get-ChildItem $nalc_xfer\DIFMRecon_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J60720*.* | Rename-Item -NewName { $_.name -Replace 'J60720*.','SubcustodySuspenseRecon_' }
Get-ChildItem $nalc_xfer\SubcustodySuspenseRecon_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\E60450*.* | Rename-Item -NewName { $_.name -Replace 'E60450*.','NalcOutgoing_' }
Get-ChildItem $nalc_xfer\NalcOutgoing_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Get-ChildItem $nalc_xfer\J72400*.* | Rename-Item -NewName { $_.name -Replace 'J72400*.','HiPriReport_' }
Get-ChildItem $nalc_xfer\HiPriReport_*  | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "txt") }

Write-Host "Creating folders..." # user info prompt

New-Item -Path "$desktop\$JulianDate File Transfers" -ItemType Directory # create a julian date folder on the current users desktop

$txtfilecount = [System.IO.Directory]::GetFiles("$rsup_xfer", "*.txt").Count + [System.IO.Directory]::GetFiles("$nalc_xfer", "*.txt").Count # count files in both xfer folders
Write-Host "Moving $txtfilecount file(s) to File Transfer folder..." # user info prompt
Move-Item -Path $rsup_xfer\*.txt -Destination "$desktop\$JulianDate File Transfers" # move all txt files in RSupply xfer folder to julian date folder on desktop
Move-Item -Path $nalc_xfer\*.txt -Destination "$desktop\$JulianDate File Transfers" # move all txt files in NALCOMIS xfer folder to julian date folder on desktop

$ping = Read-Host "Do you wish to copy these files to the sharedrive? (Y/N)" # ask the user if they want the files duplicated on the sharedrive
If ($ping -eq "Y") {
    New-Item -Path "$sharedrive\$JulianDate" -ItemType Directory
    Copy-Item -Path "$desktop\$JulianDate File Transfers\*.txt" -Destination $sharedrive\$JulianDate -Recurse
    Write-Host "Files copied to Sharedrive"
}
Else {
    Write-Host "No files copied to Sharedrive"
}

Write-Host "Creating TIR Date Folder..." # user info prompt
New-Item -Path "C:\TIR\$DateFolder" -ItemType Directory # create a current TIR folder on the C: drive

$tirfilecount = [System.IO.Directory]::GetFiles("$rsup_xfer", "ULM*.*").Count # counts TIR files in RSupply Xfer folder
Write-Host "Moving $tirfilecount TIR file(s)..." # user info prompt
Move-Item -path $rsup_xfer\ULM*.* -Destination C:\TIR\$DateFolder # move all TIR files to TIR File folder

$fincount = [System.IO.Directory]::GetFiles("$desktop\$JulianDate File Transfers", "*.txt").Count # total count of files moved
Write-Host "Process complete. $fincount file(s) affected." # user info prompt
Read-Host "Press ENTER to exit..."