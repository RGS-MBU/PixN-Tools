@echo off
echo .
echo Starting a full clone/download...
echo .
cd ..\..\emulationstation\.emulationstation\themes
rmdir /S /Q "Alekfull-ARTFLIX-PixN"
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/Alekfull-ARTFLIX-PixN.git

echo .
echo .
pause