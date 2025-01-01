@REM Copyright 2018-2025 Mickaël Schoentgen & contributors
@REM Copyright 2012-2018 Google, Inc.
@REM Copyright 2011-2012 Yesudeep Mangalapilly
@REM Copyright 2001-2010 The SCons Foundation
@REM watchmedo.bat - Wrapper .bat file for the watchmedo Python script.

@echo off
set SCRIPT_ERRORLEVEL=
if "%OS%" == "Windows_NT" goto WinNT

@REM Windows 9x/Me you better not have more than 9 arguments.
python -c "from watchdog import watchmedo; watchmedo.main()" %1 %2 %3 %4 %5 %6 %7 %8 %9
@REM No way to set exit status of this script for 9x/Me
goto endscript

@REM Windows NT+
:WinNT
setlocal
set path=%~dp0;%~dp0..;%path%
python -c "from watchdog import watchmedo; watchmedo.main()" %*
endlocal & set SCRIPT_ERRORLEVEL=%ERRORLEVEL%

if not "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto returncode
if errorlevel 9009 echo You do not have python in your PATH environment variable.
goto endscript

:returncode
exit /B %SCRIPT_ERRORLEVEL%

:endscript
call :returncode %SCRIPT_ERRORLEVEL%
