@echo off
echo .
echo Starting a full clone/download...
echo .
cd ..\..\emulationstation\.emulationstation\themes
rmdir /S /Q "Hypermax-Plus-PixN"
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/Hypermax-Plus-PixN.git

echo .
echo .
pause
