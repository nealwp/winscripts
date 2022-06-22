@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET sharedrive=\\NENT95PNDLVS001\New_MAW_3rd\3MAW Shared Drive\MAG-11\MALS-11\02. Supply\ALL SUPPLY\Daily reports\
SET yearpart=%date:~13, 1%

FOR /f "tokens=2-4 delims=/ " %%a IN ("%date%") DO (
   SET /A "MM=1%%a-100, DD=1%%b-100, Ymod4=%%c%%4"
)
FOR /f "tokens=%MM%" %%m IN ("0 31 59 90 120 151 181 212 243 273 304 334") DO SET /a jdate=DD+%%m
IF %Ymod4% EQU 0 IF %MM% gtr 2 SET /a jdate+=1

IF EXIST "%sharedrive%%yearpart%%jdate%" ( 

FIND /c /v "" "%sharedrive%%yearpart%%jdate%\*" > C:\xfer\txt\daily-count.txt

FOR /f "tokens=*" %%a IN ('type C:\xfer\txt\daily-count.txt') DO (
SET line=%%a
ECHO -- !line:~115!
)
) ELSE (
  ECHO %sharedrive%%jdate% does not exist
)

PAUSE