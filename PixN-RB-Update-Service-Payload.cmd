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
echo Version 1.08
echo .
ping -n 2 127.0.0.1 > nul

REM This section pulls down the latest custom system config files...
echo .
echo Updating system config files...
echo .
ping -n 2 127.0.0.1 > nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/emulationstation.git
move /Y ".\emulationstation\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\
rmdir /S /Q ".\emulationstation"
ping -n 2 127.0.0.1 > nul
echo .

REM This section restores the PixN Update Service artwork...
REM *
REM ***The gamelist.xml file will possibly need updating if the version of RetroBat is upgraded...**
REM *
echo Restoring PixN Update Service artwork...
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/RB-es_menu-gamelist.xml -O gamelist.xml
ping -n 2 127.0.0.1 > nul
move /Y "gamelist.xml" ..\..\system\es_menu\
ping -n 2 127.0.0.1 > nul
echo .

REM This section applies the PinballFX and Piball M Fix...
echo PinballFX and Piball M Fix...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/Pin-Lic.7z -O Pin-Lic.7z
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/7z.exe -O 7z.exe
ping -n 2 127.0.0.1 > nul
7z x Pin-Lic.7z -aoa -p22446688 -o.\
echo .
REM Set PixN-Dir="%cd%"
md "%localappdata%\PinballFX" >nul 2>&1
md "%localappdata%\PinballM" >nul 2>&1

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I >nul 2>&1
echo Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I >nul 2>&1

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1

rmdir /S /Q "PinballFX" >nul 2>&1
rmdir /S /Q "PinballM" >nul 2>&1
del /Q Pin-Lic.7z
ping -n 2 127.0.0.1 > nul

REM This sections fixes the version of the Archmendes BIOS files...
echo Downloading updated Archmendes BIOS files...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/arch-b.7z -O arch-b.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x arch-b.7z -aoa -p22446688 -o.\
echo .
echo Moving files...
move /Y "aa310.zip" ..\..\bios\
move /Y "archimedes_keyboard.zip" ..\..\bios\
ping -n 2 127.0.0.1 > nul
del /Q arch-b.7z
echo .
ping -n 2 127.0.0.1 > nul

REM This section downloads the latest 3dSen Emulator...
echo Downloading the latest 3dSen Emulator...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/3d-N.7z.001 -O 3d-N.7z.001
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/3d-N.7z.002 -O 3d-N.7z.002
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/3d-N.7z.003 -O 3d-N.7z.003
wget https://raw.githubusercontent.com/RGS-MBU/PixN-Tools/main/3d-N.7z.004 -O 3d-N.7z.004
ping -n 2 127.0.0.1 > nul
echo .
7z x 3d-N.7z.001 -aoa -p22446688 -o.\
md ..\..\emulators\3dsen >nul 2>&1
echo .
echo Copying files...
xcopy 3dsen ..\..\emulators\3dsen\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q 3d-N.7z.001
del /Q 3d-N.7z.002
del /Q 3d-N.7z.003
del /Q 3d-N.7z.004
rmdir /S /Q 3dsen >nul 2>&1
echo .

ping -n 2 127.0.0.1 > nul

REM This section enables HD texture packs for the NES HD system...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Backup the original file
copy "%filePath%" "%filePath%.bak"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"nes_hd.hd_packs\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"nes_hd.hd_packs\" value=\"enabled\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal

REM The theme updates section needs to be the last thing to run as it changes the current directory...

echo .
echo Updating Hypermax-Plus-PixN Theme...
cd ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo Updating Ckau-Book-PixN Theme...
cd ..\ckau-book-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo Updating Carbon-PixN Theme...
cd ..\Carbon-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

rem echo Updating Alekfull-ARTFLIX-PixN Theme...
rem cd ..\Alekfull-ARTFLIX-PixN
rem ..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
rem echo .
rem ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo .
echo All done, once this script closes, please restart RetroBat for any changes to take effect... :)
ping -n 5 127.0.0.1 > nul

exit
