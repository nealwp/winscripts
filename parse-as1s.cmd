@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET drive=C:\Users\%USERNAME%\Documents
SET yearpart=%date:~13, 1%

FOR /f "tokens=2-4 delims=/ " %%a IN ("%date%") DO (
   SET /A "MM=1%%a-100, DD=1%%b-100, Ymod4=%%c%%4"
)
FOR /f "tokens=%MM%" %%m IN ("0 31 59 90 120 151 181 212 243 273 304 334") DO SET /a jdate=DD+%%m
IF %Ymod4% EQU 0 IF %MM% gtr 2 SET /a jdate+=1

SET statusfile="RSMS%date:~-4%%jdate% INCOMING.TXT"
 
FOR /f "tokens=*" %%a IN ('type "%drive%\"%statusfile%""') DO (
SET line=%%a
ECHO "!line:~0,3!"
IF "!line:~0,3!"=="AS1" (ECHO !line! >> %drive%\%date:~-4%%jdate%_AS1.txt)
)

PAUSE