param (
    [string]$action,
    [string]$app
)

switch ($app) {
    "vhs" {
        $awsProfile = "vhs"
        $instanceID = "i-00edf83c471d4dcfd"
        $securityGroup = "sg-027a0aefff6c4a1d0"
        break
    }
    "vhs-cms" {
        $awsProfile = "vhs"
        $instanceID = "i-02a20fdc75fc916ac"
        $securityGroup = "sg-027a0aefff6c4a1d0"
        break
    }
    "tfm-portal" {
        $awsProfile = "tfm"
        $instanceID = "i-0dd57bdfa03479e77"
        $securityGroup = "sg-00f442b3324153ed8"
        break
    }
    "tfms" {
        $awsProfile = "tfm"
        $instanceID = "i-09f0ee0de5d1b26ca"
        $securityGroup = "sg-00f442b3324153ed8"
        break
    }
    Default {
        "Error: App $app not recognized."
        exit
    }
}

switch ($action) {
    "start" {
        $result = aws ec2 start-instances --instance-id $instanceID --profile $awsProfile | ConvertFrom-Json
        if ($null -ne $result.StartingInstances[0].CurrentState.Name) {
            "$app status: " + $result.StartingInstances[0].CurrentState.Name
        } else {
            $result
        }
    }
    "reboot" {
        aws ec2 reboot-instances --instance-id $instanceID --profile $awsProfile
    }
    "stop" {
        $result = aws ec2 stop-instances --instance-id $instanceID --profile $awsProfile | ConvertFrom-Json
        if ($null -ne $result.StoppingInstances[0].CurrentState.Name) {
            "$app status: " + $result.StoppingInstances[0].CurrentState.Name
        } else {
            $result
        }       
    }
    "status" {
        $result = aws ec2 describe-instance-status --instance-id $instanceID --profile $awsProfile | ConvertFrom-Json
        if ($null -ne $result.InstanceStatuses[0].InstanceState.Name) {
            "$app status: " + $result.InstanceStatuses[0].InstanceState.Name
        } else {
            $result
        }        
    }
    "fix-security-group" {
        $result1 = aws ec2 modify-instance-attribute --instance-id $instanceID --groups $securityGroup --profile $awsProfile
	    $result2 = aws ec2 delete-tags --resources $instanceID --tags Key=netsec_bstatus,Value=Compromised --profile $awsProfile
        if ($null -eq $result1 -and $null -eq $result2){
            "Update security group for $app complete."
        } else {
            $result1
            $result2
        }
    }
    Default {
        "Error: Action $action not recognized."
        exit
    }
}
