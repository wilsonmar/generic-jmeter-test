@echo off
rem JMETER_BIN environment variable needs to be set to run this script.
rem if you are not allowed to do that on your system, uncomment the following line and fill in the correct path
rem set JMETER_BIN=C:\path\to\jmeter\bin\

if .%JMETER_BIN%  == . goto abort

rem rem
rem PREPARATION
rem rem

set testProperties=test.properties
set testFile=test.jmx
set resultFile=result.csv
set jmeterLogFile='jmeter_'yyyyMMddHHmmss'.log'

rem "-n" means no GUI, "-r" means that test will be started on remote servers
set jmeterArgs=-n -r
rem set jmeterArgs=

rem uncomment for debug logging from jmeter
rem set jmeterargs=%jmeterArgs% -LDEBUG

rem rem
rem / PREPARATION
rem rem


rem JMETER_BIN is set, run script.
call %JMETER_BIN%\jmeter %jmeterArgs% -t %testFile% -l %resultFile% -p %testProperties% -j %jmeterLogFile%
goto END

:abort
echo "Aborting: JMETER_BIN environment variable is not set. Please set JMETER_BIN to jmeter install/bin directory."
pause
goto END

:END