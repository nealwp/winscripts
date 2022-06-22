@echo off
setlocal EnableDelayedExpansion

if %1 EQU start set _command=start-instances
if %1 EQU reboot set _command=reboot-instances
if %1 EQU stop set _command=stop-instances
if %1 EQU status set _command=describe-instance-status
if %1 EQU fix-sec-group set _command=modify-instance-attribute

if %2 EQU vhs-prod (
	set _instance_id=i-00edf83c471d4dcfd
	set _profile=vhs
    set _security_group=sg-027a0aefff6c4a1d0
) else if %2 EQU vhs-cms-prod (
	set _instance_id=i-02a20fdc75fc916ac
	set _profile=vhs
    set _security_group=sg-027a0aefff6c4a1d0
) else if %2 EQU tfms (
    set _instance_id=i-09f0ee0de5d1b26ca
	set _profile=tfm
     set _security_group=sg-00f442b3324153ed8
) else if %2 EQU tfm-portal (
    set _instance_id=i-0dd57bdfa03479e77
    set _profile=tfm
    set _security_group=sg-00f442b3324153ed8
) else (
    echo "ERROR: no profile for %2"
    exit
)

if %_command% EQU modify-instance-attribute (
    echo %_profile% %_security_group% %_instance_id%
	aws ec2 modify-instance-attribute --instance-id %_instance_id% --groups %_security_group% --profile %_profile%
	aws ec2 delete-tags --resources %_instance_id% --tags Key=netsec_bstatus,Value=Compromised --profile %_profile%
	exit
)

echo %_command% %_instance_id%

if defined _command (
	if defined _instance_id (
		aws ec2 %_command% --instance-id %_instance_id% --profile %_profile%
	)
)


