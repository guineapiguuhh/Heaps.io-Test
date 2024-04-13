@echo off
cd ..

echo Deleting the Old Files...
del hello.js
del hello.js.map

echo Compiling the Application...
haxe compile.hxml

echo Starting the Application...
start index.html

pause