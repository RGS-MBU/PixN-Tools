@echo off
echo .
echo Starting a full clone/download...
echo .
cd ..\..\emulationstation\.emulationstation\themes
rmdir /S /Q "Carbon-PixN"
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/Carbon-PixN.git

echo .
echo .
pause
