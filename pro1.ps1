@echo off
Color 0A

:menu
ECHO -------------##########------------
echo.
echo 1. Instala SAP V8 y crea conexiones
echo 2. Instala GIRAFE
echo 3. Instala OpenSmart
echo 4. Instala Condis
echo 5. Instala Onefield
echo 6. OFFICE 365
echo 7. Todos los ACCESOS(iticket, Tapps, smart, etc)
echo 8. COPY_PERFIL
echo 9. DESHABILITAR SYSMAIN Y EXPERENCIA DEL USUARIO
echo 10. Instala Google Earth
echo 11. Instala Viewfinity Agent
echo 12. Copiar carpetas (mas rapido)
echo 13. Instala BentleyView
echo 14. Instala VMWare client Vditeco
echo 15. Abre CMD repositorio
echo 16. Regedit suspension SSD
echo 99. EXIT
echo.

set /p opcion= elije una opcion: 
if not defined opcion goto :menu
if %opcion% GTR 99 Exit

goto :opcion%opcion%

:SAPGUIV8
@echo off
pushd \\aest-repo1\paquetes
cd "SAP GUI V8 win64"
SAPGUIv8_64bits_20230606_1703.exe
pause
GUI800_2-80006342.EXE
cd\
ECHO ###########
@echo off
C:
set /p UsuarioN=Ingresa el usuario:
cd C:\Users\%UsuarioN%\AppData\Roaming
MD SAP
cd C:\Users\%UsuarioN%\AppData\Roaming\SAP
MD Common
CD C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
pushd \\aest-repo1\paquetes
cd "SAP GUI V8 win64\SAPFILES"
copy /Y saplogon.ini C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
copy /Y SAPUILandscape.xml C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
copy /Y SAPUILandscapeGlobal.xml C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
pause
goto :menu

:GIRAFE
@echo off
pushd \\aest-repo1\paquetes
cd girafe\girafe
cscript.exe Install.vbs
cd "Girafe"
Girafe_Sesiones.EXE
cd\
pause
goto :menu

:OPEN
@echo off
pushd \\aest-repo1\paquetes
cd "Open SmartFlex 7.5\Open SmartFlex 7.5 - x86x64\x64"
start /wait .\OSFSetup.exe /S
icacls "C:\Program Files (x86)\OpenSystems" /q /c /t /grant TODOS:(OI)(CI)F
REM Extrae ejecutables Fixeados con Zip para mejorar transferencia
start /wait "" 7z.exe x "OpenSmartFlex-patch.7z" -o"C:\Program Files (x86)\OpenSystems\OpenSmartFlex" -y
REM Copia DLL Wondersoft
copy /y .\WOIN3.dll "C:\Program Files (x86)\OpenSystems\OpenSmartFlex"
cd\
pause
goto :menu

:Condis
@echo off
pushd \\aest-repo1\paquetes
cd "CONDIS Client C12 64 BITS NI - NEW\INSTALL" 
CONDIS Client C12 64 BITS NI.EXE
cd..
cd "Condis Client C12 NRED\Install"
Condis Client C12 NRED.EXE
cd\
pause
goto :menu

:Onefield
@echo off
pushd \\aest-repo1\paquetes
If NOT EXIST "C:\CSGSystems\" GoTo InstaladesdeCero

cscript.exe "Install_Update.vbs"
icacls "C:\CSGSystems" /q /c /t /grant USUARIOS:(OI)(CI)M
GOTO EXIT

:InstaladesdeCero
cd "CableVision - Aplicaciones\CSG Onefield - Update 28-03-21"
start /wait msiexec.exe /i "One Field.msi" /qn ALLUSERS=2
cscript.exe "Install_Update.vbs"
icacls "C:\CSGSystems" /q /c /t /grant USUARIOS:(OI)(CI)M
cd\
pause
goto :menu

...

:EXIT
exit
