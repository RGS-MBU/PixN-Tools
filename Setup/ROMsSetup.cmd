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

REM CSCRIPT //nologo "%TempVBSFile%"

:START
CLS
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
echo                             ___
echo                           ,"---".
echo                           :     ;
echo                            `-.-'
echo                             ^| ^|
echo                             ^| ^|
echo                             ^| ^|
echo                          _.-\_/-._
echo                       _ / ^|     ^| \ _
echo                      / /   `---'   \ \
echo                     /  `-----------'  \
echo                    /,-""-.       ,-""-.\
echo                   ( i-..-i       i-..-i )
echo                   ^|`^|    ^|-------^|    ^|'^|
echo                   \ `-..-'  ,=.  `-..-'/
echo                    `--------^|=^|-------'
echo                             ^| ^|
echo                             \ \
echo                              ) )
echo                             / /
echo                            ( (
echo ..............................................................
echo ........Welcome to the Team Pixel Nostalgia ROM Wizard........
echo ..............................................................
ping -n 2 127.0.0.1 > nul

rem Change the current directory to the directory where the script is located
cd /d "%~dp0"

:inputLoop
rem Prompt the user to enter the drive letter for the ROMs
echo.
echo This setup will install all or selective RomPacks.
echo.
set /p "driveLetter=Enter the drive letter where you want the ROMs extracted... (e.g., C): "
echo.
rem Validate the input to ensure it's only a single letter and not A or B
if "%driveLetter:~1%" neq "" (
    echo Invalid drive letter. Please enter only a single letter.
    goto inputLoop
)

rem Check if the specified drive exists
if not exist %driveLetter%: (
    echo Specified drive does not exist.
    goto inputLoop
)

rem Set the ROMsPath to the specified drive
set "ROMsPath=%driveLetter%:\PixN-ROMs"

rem Check if ROMs folder already exists
if exist "%ROMsPath%\*" (
    choice /C YN /M "ROMs folder already exists on the specified drive. Do you want to overwrite it"
    if errorlevel 2 (
        echo.
		echo Returning to the start...
		timeout /t 3 >nul
		echo.
		goto START
    ) else (
        echo.
		echo Extracting ROMs to %ROMsPath%...
	)
)

dir "..\ROMs Starter Pack\*.7z" > nul 2>&1
if %errorlevel% equ 0 (
    choice /C YN /M "Do you want to extract ALL RomPacks"
    if errorlevel 2 (
        echo.
		echo Entering individual RomPack mode...
		echo.
        for %%f in ("..\ROMs Starter Pack\*.7z") do (
            choice /C YN /M "Do you want to extract %%~nxf"
            if errorlevel 2 (
                echo Skipping extraction of %%~nxf.
            ) else (
                rem Check if RomPack archive has already been extracted
                if exist "%ROMsPath%\roms\%%~nf" (
                    choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                    if errorlevel 2 (
                        echo Skipping extraction of %%~nxf.
                    ) else (
                        echo Extracting %%~nxf to %ROMsPath%\roms...
                        7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                        if errorlevel 1 (
                            echo Error: Extraction of %%~nxf failed.
                        ) else (
                            echo Extraction of %%~nxf completed.
                        )
                    )
                ) else (
                    echo.
					echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            )
        )
    ) else (
        echo.
		echo Extracting all RomPacks...
        echo.
		for %%f in ("..\ROMs Starter Pack\*.7z") do (
            rem Check if RomPack archive has already been extracted
            if exist "%ROMsPath%\roms\%%~nf" (
                choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                if errorlevel 2 (
                    echo Skipping extraction of %%~nxf.
                ) else (
                    echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            ) else (
                echo Extracting %%~nxf to %ROMsPath%\roms...
                7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                if errorlevel 1 (
                    echo Error: Extraction of %%~nxf failed.
                ) else (
                    echo Extraction of %%~nxf completed.
                )
            )
        )
    )
) else (
    echo No .7z archives found in RomPacks folder.
    echo Use the checkbox selection inside the torrent content in order to download more RomPacks.
)

cls

:inputLoop2
echo.
echo ..............................................................
echo ....This section allows you to extract the 'Batocera Only'....
echo .................and 'RetroBat Only' RomPacks.................
echo ..............................................................
echo.

choice /C YN /M "Do you want to extract the 'Batocera Only' ROMs..."
    if errorlevel 2 (
        echo.
		goto RB-Roms
    ) else (
        echo.
	)

:Bat-ROMs
rem Set the ROMsPath to the specified drive
set "ROMsPath=%driveLetter%:\PixN-ROMs-Batocera"

rem Check if ROMs folder already exists
if exist "%ROMsPath%\*" (
    choice /C YN /M "ROMs folder already exists on the specified drive. Do you want to overwrite it"
    if errorlevel 2 (
        echo.
		echo Returning to the start of this section...
		timeout /t 3 >nul
		echo.
		goto inputLoop2
    ) else (
        echo.
		echo Extracting ROMs to %ROMsPath%...
	)
)

dir "..\ROMs Starter Pack\Batocera Only\*.7z" > nul 2>&1
if %errorlevel% equ 0 (
    choice /C YN /M "Do you want to extract ALL the Batocera RomPacks"
    if errorlevel 2 (
        echo.
		echo Entering individual RomPack mode...
		echo.
        for %%f in ("..\ROMs Starter Pack\Batocera Only\*.7z") do (
            choice /C YN /M "Do you want to extract %%~nxf"
            if errorlevel 2 (
                echo Skipping extraction of %%~nxf.
            ) else (
                rem Check if RomPack archive has already been extracted
                if exist "%ROMsPath%\roms\%%~nf" (
                    choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                    if errorlevel 2 (
                        echo Skipping extraction of %%~nxf.
                    ) else (
                        echo Extracting %%~nxf to %ROMsPath%\roms...
                        7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                        if errorlevel 1 (
                            echo Error: Extraction of %%~nxf failed.
                        ) else (
                            echo Extraction of %%~nxf completed.
                        )
                    )
                ) else (
                    echo.
					echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            )
        )
    ) else (
        echo.
		echo Extracting all RomPacks...
        echo.
		for %%f in ("..\ROMs Starter Pack\Batocera Only\*.7z") do (
            rem Check if RomPack archive has already been extracted
            if exist "%ROMsPath%\roms\%%~nf" (
                choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                if errorlevel 2 (
                    echo Skipping extraction of %%~nxf.
                ) else (
                    echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            ) else (
                echo Extracting %%~nxf to %ROMsPath%\roms...
                7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                if errorlevel 1 (
                    echo Error: Extraction of %%~nxf failed.
                ) else (
                    echo Extraction of %%~nxf completed.
                )
            )
        )
    )
) else (
    echo No .7z archives found in 'Batocera Only' folder.
    echo Use the checkbox selection inside the torrent content in order to download these RomPacks.
)



:RB-Roms
echo.
choice /C YN /M "Do you want to extract the 'RetroBat Only' ROMs..."
    if errorlevel 2 (
        echo.
		goto END
    ) else (
        echo.
	)

rem Set the ROMsPath to the specified drive
set "ROMsPath=%driveLetter%:\PixN-ROMs-RetroBat"

rem Check if ROMs folder already exists
if exist "%ROMsPath%\*" (
    choice /C YN /M "ROMs folder already exists on the specified drive. Do you want to overwrite it"
    if errorlevel 2 (
        echo.
		echo Returning to the start of this section...
		timeout /t 3 >nul
		echo.
		goto RB-Roms
    ) else (
        echo.
		echo Extracting ROMs to %ROMsPath%...
	)
)

dir "..\ROMs Starter Pack\RetroBat Only\*.7z" > nul 2>&1
if %errorlevel% equ 0 (
    choice /C YN /M "Do you want to extract ALL the RetroBat RomPacks"
    if errorlevel 2 (
        echo.
		echo Entering individual RomPack mode...
		echo.
        for %%f in ("..\ROMs Starter Pack\RetroBat Only\*.7z") do (
            choice /C YN /M "Do you want to extract %%~nxf"
            if errorlevel 2 (
                echo Skipping extraction of %%~nxf.
            ) else (
                rem Check if RomPack archive has already been extracted
                if exist "%ROMsPath%\roms\%%~nf" (
                    choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                    if errorlevel 2 (
                        echo Skipping extraction of %%~nxf.
                    ) else (
                        echo Extracting %%~nxf to %ROMsPath%\roms...
                        7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                        if errorlevel 1 (
                            echo Error: Extraction of %%~nxf failed.
                        ) else (
                            echo Extraction of %%~nxf completed.
                        )
                    )
                ) else (
                    echo.
					echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            )
        )
    ) else (
        echo.
		echo Extracting all RomPacks...
        echo.
		for %%f in ("..\ROMs Starter Pack\RetroBat Only\*.7z") do (
            rem Check if RomPack archive has already been extracted
            if exist "%ROMsPath%\roms\%%~nf" (
                choice /C YN /M "RomPack %%~nxf already exists. Do you want to overwrite it"
                if errorlevel 2 (
                    echo Skipping extraction of %%~nxf.
                ) else (
                    echo Extracting %%~nxf to %ROMsPath%\roms...
                    7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                    if errorlevel 1 (
                        echo Error: Extraction of %%~nxf failed.
                    ) else (
                        echo Extraction of %%~nxf completed.
                    )
                )
            ) else (
                echo Extracting %%~nxf to %ROMsPath%\roms...
                7z x "%%f" -o"%ROMsPath%\roms" -y > nul
                if errorlevel 1 (
                    echo Error: Extraction of %%~nxf failed.
                ) else (
                    echo Extraction of %%~nxf completed.
                )
            )
        )
    )
) else (
    echo No .7z archives found in 'RetroBat Only' folder.
    echo Use the checkbox selection inside the torrent content in order to download these RomPacks.
)

:END
echo.
echo All done, enjoy!
echo.
echo Press any key to exit...
pause > nul 2>&1
exit
