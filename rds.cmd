@echo off
setlocal EnableDelayedExpansion

if %1 EQU start set _command=start-db-instance
if %1 EQU reboot set _command=reboot-db-instance
if %1 EQU stop set _command=stop-db-instance
if %1 EQU status set _command=describe-db-instances

if %2 EQU tfmdb (
	set _db_instance_id=totalforcemanagement
	set _profile=tfm
)

echo %_command% %_db_instance_id%

if defined _command (
	if defined _db_instance_id (
		aws rds %_command% --db-instance-identifier %_db_instance_id% --profile %_profile%
	)
)