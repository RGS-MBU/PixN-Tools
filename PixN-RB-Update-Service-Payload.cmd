@echo off

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

rem Script to send the window full screen
:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

rem Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo .
echo Pixel Nostalgia updater running...
echo Version 1.07
echo .
ping -n 2 127.0.0.1 > nul

echo .
echo Updating system config files...
echo .
ping -n 2 127.0.0.1 > nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/emulationstation.git
move /Y ".\emulationstation\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\
rmdir /S /Q ".\emulationstation"
ping -n 2 127.0.0.1 > nul
echo .

echo Restoring PixN Update Service artwork...
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/RB-es_menu-gamelist.xml -O gamelist.xml
ping -n 2 127.0.0.1 > nul
move /Y "gamelist.xml" ..\..\system\es_menu\
ping -n 2 127.0.0.1 > nul
echo .

echo PinballFX and Piball M Fix...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/Pin-Lic.zip -O Pin-Lic.zip
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/7z.exe -O 7z.exe
ping -n 2 127.0.0.1 > nul
7z x Pin-Lic.zip -aoa -o.\
echo .
Set PixN-Dir="%cd%"
md "%localappdata%\PinballFX" >nul 2>&1
md "%localappdata%\PinballM" >nul 2>&1

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I >nul 2>&1
echo Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I >nul 2>&1

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561199698107109 /w:0 /r:0 >nul 2>&1
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561199698107109 /w:0 /r:0 >nul 2>&1

rmdir /S /Q "PinballFX" >nul 2>&1
rmdir /S /Q "PinballM" >nul 2>&1

ping -n 2 127.0.0.1 > nul

echo .
echo Updating Hypermax-Plus-PixN Theme...
cd ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

echo Updating Ckau-Book-PixN Theme...
cd ..\ckau-book-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

echo Updating Carbon-PixN Theme...
cd ..\Carbon-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem echo Updating Alekfull-ARTFLIX-PixN Theme...
rem cd ..\Alekfull-ARTFLIX-PixN
rem ..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
rem echo .
rem ping -n 2 127.0.0.1 > nul

echo .
echo All done, once this script closes, please restart RetroBat for any changes to take effect... :)
ping -n 5 127.0.0.1 > nul

exit
