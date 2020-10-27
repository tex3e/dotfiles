@echo off

set TO_DIR=%HomeDrive%%HomePath%\Documents\Apps\Keypirinha
set FROM_DIR=%~dp0

openfiles > NUL 2>&1
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin
  call :backup_and_mklink portable\Profile\User\Keypirinha.ini
  call :backup_and_mklink portable\Profile\User\filescatalog.ini
  call :backup_and_mklink portable\Profile\User\bookmarks.ini
  echo [info]: Setup Finished!
goto End
:NotAdmin
  echo This command prompt is NOT ELEVATED
:End

pause

exit /b


REM サブルーチン：バックアップの作成とリンクの作成
:backup_and_mklink
if exist "%TO_DIR%\%~1" (
  MOVE "%TO_DIR%\%~1" "%TO_DIR%\%~1.orig"
)
if "%~2"=="" (
  MKLINK "%TO_DIR%\%~1" "%FROM_DIR%\%~1"
) else (
  MKLINK "%TO_DIR%\%~1" "%FROM_DIR%\%~2"
)
exit /b
