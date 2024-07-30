@echo off

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

rem Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo .
echo Pixel Nostalgia updater running...
echo .
ping -n 2 127.0.0.1 > nul
echo Updating Hypermax-Plus-PixN Theme...

cd ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
ping -n 2 127.0.0.1 > nul
echo .
echo Updating Ckau-Book-PixN Theme...
ping -n 2 127.0.0.1 > nul
cd ..\ckau-book-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull

echo .
ping -n 2 127.0.0.1 > nul
exit
