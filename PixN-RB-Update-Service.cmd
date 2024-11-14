@echo off
setlocal

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

echo .
echo Updating the script...
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/PixN-RB-Update-Service-Payload.cmd -O PixN-RB-Update-Service-Payload.cmd
ping -n 2 127.0.0.1 > nul
start /wait PixN-RB-Update-Service-Payload.cmd
exit