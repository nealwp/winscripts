@echo off
set /p filepath="Enter the filepath: D:/"
set /p filename="Enter the filename: D:/%filepath%/"

pscp -scp mrprestonneal@outlook.com@DESKTOP-0F7POD2:D:/%filepath%/%filename% C:/Users/Owner/Desktop/%filename%

@echo on