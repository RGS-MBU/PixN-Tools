@echo off
echo .
echo Starting a full clone/download...
echo .
cd ..\..\emulationstation\.emulationstation\themes
rmdir /S /Q "ckau-book-PixN"
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/ckau-book-PixN.git

echo .
echo .
pause
