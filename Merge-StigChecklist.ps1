<#
.SYNOPSIS
    Merge STIG checklist to updated checklist
.DESCRIPTION
    This script is used to automatically merge an old STIG checklist to a new checklist revision.

    By using the Rule_ver attribute in the STIG XML it can match STIGs of the same technology with vastly different versions,
    and it will compare the Fix Text between the 2 checklists to determine if the check has changed in any meaningful way.

    This script will always merge the COMMENTS and the FINDING_DETAILS to the new checklist.
    
    If the Fix Text of the check matches, it will also merge the check STATUS (NAF, NA, Open) and any SECURITY_OVERRIDE information.

    If the Fix Text does not match, it will merge the COMMENTS and log the check in the <STIG>_NeedsReview.csv file for manual review.
.PARAMETER OldChecklist
    The path to the old CKL file
.PARAMETER NewChecklist
    The path to the new CKL file
.PARAMETER ChecklistPrefix
    Appends a prefix to the start of the new checklist that is generated at the end
.PARAMETER IgnoreStigIdMismatch
    In the event that the STIG ID has been changed but the technology is the same between the 2 checklists, it will attempt to merge
    the checklists, though success is not guaranteed.
.EXAMPLE
    PS C:\> .\Merge-StigChecklist.ps1 -OldChecklist c:\STIGs\U_MS_Windows_Server_2019_STIG_V1R2.ckl -NewChecklist c:\STIGs\U_MS_Windows_Server_2019_V2R1_STIG.ckl
    
    Merges the Windows Server 2019 V1R2 STIG with the Windows Server 2019 V2R1 STIG
.NOTES
    For any issues contact James Curtin
    email: jcurtin@spawar.navy.mil
#>
Param (
    [string]$OldChecklist,
    [string]$NewChecklist,
    [string]$ChecklistPrefix = 'PAC',
    [switch]$IgnoreStigIdMismatch
)

Start-Transcript -Path $PSScriptRoot\STIG_Log.txt

[xml]$OldCKL = Get-Content $OldChecklist -Encoding UTF8
[xml]$NewCKL = Get-Content $NewChecklist -Encoding UTF8

# Checks to make sure the STIG ID Matches between the two checklists
if(!$IgnoreStigIdMismatch.IsPresent){
    $OldID = ($OldCKL.CHECKLIST.STIGS.iSTIG.STIG_INFO.SI_DATA | where SID_NAME -eq 'stigid').SID_DATA
    $NewID = ($NewCKL.CHECKLIST.STIGS.iSTIG.STIG_INFO.SI_DATA | where SID_NAME -eq 'stigid').SID_DATA
    if($OldID -ne $NewID){
        Write-Warning "The STIG ID value of the old checklist ($OldID) does not match the STIG ID of the new checklist ($NewID).`n`nIf this is expected, rerun the script with the -IgnoreStigIdMismatch switch`n`n"
        exit
    }
}

$OutPath = (Get-Item $NewChecklist).Directory.FullName
$NewFile = $OutPath + "\" + ((Get-Item $NewChecklist).Name -replace '(.+)',"$ChecklistPrefix`_`$1")
$StigID = ($NewCKL.CHECKLIST.STIGS.iSTIG.STIG_INFO.SI_DATA | where SID_NAME -eq 'stigid').SID_DATA

$NewFile

if($OldCKL.CHECKLIST.STIGS.iSTIG.VULN)
{
    $checks = $OldCkl.CHECKLIST.STIGS.iSTIG.VULN | where status -NotMatch 'Not_Reviewed'
}
else
{
    $checks = $OldCKL.CHECKLIST.VULN | where status -NotMatch 'Not_Reviewed'
}

$Revisions = @()
$NeedsReview = @()
foreach($check in $checks)
{
    # Get VulnID from old checklist
    #$VulnNum = ($check.STIG_DATA | select -Property * | where {$_.VULN_ATTRIBUTE -eq 'Vuln_Num'}).ATTRIBUTE_DATA
    $RuleVer = ($check.STIG_DATA | select -Property * | where {$_.VULN_ATTRIBUTE -eq 'Rule_Ver'}).ATTRIBUTE_DATA

    # Find VulnID in new checklist
    $match = $NewCKL.CHECKLIST.STIGS.iSTIG.VULN | where {$_.STIG_DATA.ATTRIBUTE_DATA -match "\A$RuleVer\Z"}

    if($match) #-and $match.STATUS -match '(Open|Not_Reviewed)')
    {
        $OldVID = ($check.STIG_DATA | select -Property * | where {$_.VULN_ATTRIBUTE -eq 'Vuln_Num'}).ATTRIBUTE_DATA
        $NewVID = ($match.STIG_DATA | select -Property * | where {$_.VULN_ATTRIBUTE -eq 'Vuln_Num'}).ATTRIBUTE_DATA
        write-host "Found match:`n old checklist: $OldVID`n new checklist: $NewVID"
        $FixHash = $true
        if(($match.STIG_DATA | where {$_.VULN_ATTRIBUTE -eq 'Rule_ID'}).ATTRIBUTE_DATA -ne ($check.STIG_DATA | where {$_.VULN_ATTRIBUTE -eq 'Rule_ID'}).ATTRIBUTE_DATA)
        {
            $OldFixText = ($check.STIG_DATA | where {$_.VULN_ATTRIBUTE -eq 'Fix_Text'}).ATTRIBUTE_DATA -replace '\s'
            $NewFixText = ($match.STIG_DATA | where {$_.VULN_ATTRIBUTE -eq 'Fix_Text'}).ATTRIBUTE_DATA -replace '\s'

            # Compares the hash of the Fix text to the old and new checklist
            if($OldFixText.GetHashCode() -ne $NewFixText.GetHashCode())
            {
                $FixHash = $false
                $NeedsReview += [PSCustomObject]@{
                    StigID = $StigID
                    VulnID = $NewVID
                }
            }
        }

        $match.FINDING_DETAILS = $check.FINDING_DETAILS
        $match.COMMENTS         = $check.COMMENTS

        # If the Fix text hash doesn't match, it skips copying the check results to the new checklist
        if($FixHash)
        {
            $match.STATUS                 = $check.STATUS
            $match.SEVERITY_OVERRIDE      = $check.SEVERITY_OVERRIDE
            $match.SEVERITY_JUSTIFICATION = $check.SEVERITY_JUSTIFICATION

            $Revisions += [PSCustomObject]@{
                VulnID           = $NewVID
                Status           = $match.STATUS
                SeverityOverride = $match.SEVERITY_OVERRIDE
            }
        }
    }
}
$NewCKL.PreserveWhitespace = $true
$NewCKL.Save($NewFile)
$Revisions | Export-Csv $PSScriptRoot\$StigID`_Revisionlist.csv -NoTypeInformation
Write-Host -ForegroundColor Green "Checklist merge has completed, you can view the results in $PSScriptRoot\$StigID`_RevisionList.csv."
if($NeedsReview){
    $NeedsReview | Export-Csv $PSScriptRoot\$StigID`_NeedsReview.csv -NoTypeInformation
    Write-Host -ForegroundColor Yellow "Some of the checks have changed, please review the changes listed in $PSScriptRoot\$StigID`_NeedsReview.csv."
}

Stop-Transcript