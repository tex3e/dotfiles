@echo off

SET TO_DIR=%HomeDrive%%HomePath%
SET FROM_DIR=%~dp0

IF exist "%TO_DIR%\.bash_profile" (
  MOVE "%TO_DIR%\.bash_profile" "%TO_DIR%\.bash_profile.orig"
)
MKLINK "%TO_DIR%\.bash_profile" "%FROM_DIR%\.bash_profile"

IF exist "%TO_DIR%\.bashrc" (
  MOVE "%TO_DIR%\.bashrc" "%TO_DIR%\.bashrc.orig"
)
MKLINK "%TO_DIR%\.bashrc" "%FROM_DIR%\.bashrc"

IF exist "%TO_DIR%\.ubuntu.bashrc" (
  MOVE "%TO_DIR%\.ubuntu.bashrc" "%TO_DIR%\.ubuntu.bashrc.orig"
)
MKLINK "%TO_DIR%\.ubuntu.bashrc" "%FROM_DIR%\.ubuntu.bashrc"

IF exist "%TO_DIR%\.alias" (
  MOVE "%TO_DIR%\.alias" "%TO_DIR%\.alias.orig"
)
MKLINK "%TO_DIR%\.alias" "%FROM_DIR%\..\.alias"

IF exist "%TO_DIR%\.path" (
  MOVE "%TO_DIR%\.path" "%TO_DIR%\.path.orig"
)
MKLINK "%TO_DIR%\.path" "%FROM_DIR%\..\.path"

echo "[info]: Setup Finished!"

PAUSE
