#!/bin/bash
# Date : (2017-04-18 09-31)
# Last revision : (2017-04-18 09-31)
# Wine version used : 2.6
# Distribution used to test : Ubuntu 16.04 LTS
# Author : casept
# PlayOnLinux : playonlinux-4.2.10

#CHANGELOG
#[casept] (2017-04-19 12-20)
# Clean up the script, add WORKING_WINE_VERSION, PUBLISHER and GAME_URL variables

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Ruckingenur CE"
PREFIX="RuckingenurCE"
WORKING_WINE_VERSION="2.6"
GAME_URL="http://www.zachtronics.com/ruckingenur-ii/"
PUBLISHER="Zachtronics"

POL_SetupWindow_Init
POL_Debug_Init

POL_System_SetArch "x86"

POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "casept" "RuckingenurCE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
POL_Call POL_Install_dotnet20
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the setup file to run." "$TITLE"
    POL_SetupWindow_wait  "Please wait while $TITLE is installed." "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.zachtronics.com/images/ruckingenur-ce-installer.exe" "2419e668d80039f61dba73e4e9047e2c"
    POL_SetupWindow_wait "Please wait while $TITLE is installed." "$TITLE"
    POL_Wine start /unix "$POL_System_TmpDir/ruckingenur-ce-installer.exe"
    POL_Wine_WaitExit "$TITLE"
fi

POL_System_TmpDelete
POL_Shortcut "Ruckingenur CE.lnk" "$TITLE"
POL_SetupWindow_Close
exit 0
