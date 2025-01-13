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
echo .
ping -n 2 127.0.0.1 > nul

REM Download and Call the PowerShell script
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Add-PixNService.ps1 -O Add-PixNService.ps1
ping -n 2 127.0.0.1 > nul
powershell -ExecutionPolicy Bypass -File "Add-PixNService.ps1"
ping -n 2 127.0.0.1 > nul
echo .

REM This section downloads a tiny file so we can see how many people are using the Update Service...
del /Q NYcXqrtb*.* >nul 2>&1
del /Q PixN-Stats >nul 2>&1
wget https://pixeldrain.com/api/filesystem/NYcXqrtb
ren NYcXqrtb PixN-Stats
ping -n 2 127.0.0.1 > nul

REM Creates replace.vbs to update the PixN-RB-Update-Service.cmd file...
echo Const ForReading = 1 > replace.vbs
echo Const ForWriting = 2 >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo strFileName = Wscript.Arguments(0) >> replace.vbs
echo strOldText = Wscript.Arguments(1) >> replace.vbs
echo strNewText = Wscript.Arguments(2) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo Set objFSO = CreateObject("Scripting.FileSystemObject") >> replace.vbs
echo Set objFile = objFSO.OpenTextFile(strFileName, ForReading) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo strText = objFile.ReadAll >> replace.vbs
echo objFile.Close >> replace.vbs
echo strNewText = Replace(strText, strOldText, strNewText) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo objFile.Close >> replace.vbs
echo Set objFile = objFSO.OpenTextFile(strFileName, ForWriting) >> replace.vbs
echo objFile.Write strNewText >> replace.vbs
echo objFile.Close>> replace.vbs

cscript replace.vbs "PixN-RB-Update-Service.cmd" "RGS-MBU/PixN-Tools" "PixelNostalgia/PixN-RB-Update-Service" > NUL

echo .
echo Script Update Complete - Please run the PixN Update Service again to recieve the full set of updates... :)
ping -n 5 127.0.0.1 > nul

exit
