ECHO ON
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
if not defined opcion (goto:menu)
if %opcion% GTR 99 (Exit)
if %opcion%==1 goto :SAPGUIV8
if %opcion%==2 goto :GIRAFE
if %opcion%==3 goto :OPEN
if %opcion%==4 goto :Condis
if %opcion%==5 goto :Onefield
if %opcion%==6 goto :OFFICE 365
if %opcion%==7 goto :Todos los ACCESOS
if %opcion%==8 goto :COPY_PERFIL
if %opcion%==9 goto :DESHABILITAR SYSMAIN Y EXPERENCIA DEL USUARIO
if %opcion%==10 goto :GoogleE
if %opcion%==11 goto :Viewfinity
if %opcion%==12 goto :COPY_CARPETAS
if %opcion%==13 goto :BentleyView
if %opcion%==14 goto :Vmware
if %opcion%==15 goto :Vent
if %opcion%==16 goto :SSD
if %opcion%==99 goto :EXIT



:SAPGUIV8

@echo off
pushd \\aest-repo1\paquetes
cd SAP GUI V8 win64
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
cd SAP GUI V8 win64\SAPFILES
copy /Y saplogon.ini C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
copy /Y SAPUILandscape.xml C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common
copy /Y SAPUILandscapeGlobal.xml C:\Users\%UsuarioN%\AppData\Roaming\SAP\Common

pause
goto:menu

:GIRAFE

@echo off
pushd \\aest-repo1\paquetes
cd girafe\girafe
cscript.exe Install.vbs
cd "Girafe"
Girafe_Sesiones.EXE
cd\
pause
goto:menu

:OPEN

@echo off
pushd \\aest-repo1\paquetes
cd Open SmartFlex 7.5\Open SmartFlex 7.5 - x86x64\x64
start /wait .\OSFSetup.exe /S
icacls "C:\Program Files (x86)\OpenSystems" /q /c /t /grant TODOS:(OI)(CI)F
REM Extrae ejecutables Fixeados con Zip para mejorar transferencia
start /wait "" 7z.exe x "OpenSmartFlex-patch.7z" -o"C:\Program Files (x86)\OpenSystems\OpenSmartFlex" -y
REM Copia DLL Wondersoft
copy /y .\WOIN3.dll "C:\Program Files (x86)\OpenSystems\OpenSmartFlex"E
cd\
pause
goto:menu

:Condis

@echo off
pushd \\aest-repo1\paquetes
cd CONDIS Client C12 64 BITS NI - NEW\INSTALL 
CONDIS Client C12 64 BITS NI.EXE
cd..
cd Condis Client C12 NRED\Install 
Condis Client C12 NRED.EXE
cd\
pause
goto:menu

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
goto:menu
 

:OFFICE 365

@echo off
pushd \\aest-repo1\paquetes
cd Microsoft Office 365\Semiannual64
ConfigurationNueva64_con_uninstall_office2016.bat
cd\
pause
goto:menu

:Todos los ACCESOS
@echo off
pushd \\aest-repo1\paquetes
cd UPGRADE y MANTENIMIENTO/SAP_Concur-acceso
cscript.exe Install.vbs
cd\
ECHO ###########
@echo off
pushd \\aest-repo1\paquetes
cd UPGRADE y MANTENIMIENTO\SMART-acceso
cscript.exe Install.vbs
cd\
ECHO ###########
@echo off
pushd \\aest-repo1\paquetes
cd Acceso Directo\Acceso Directo Tapps (nuevo)
set "currentDirectory=%cd%
xcopy "%currentDirectory%\Tapps.ico" "C:\Windows\" /Y
xcopy "%currentDirectory%\Tapps.lnk" "C:\Users\Public\Desktop\" /Y
cd\
ECHO ###########
@echo off
pushd \\aest-repo1\paquetes
CD UPGRADE y MANTENIMIENTO\Acceso Directo Itickets
set "currentDirectory=%cd%
xcopy "%currentDirectory%\itickets.ico" "C:\Windows\" /Y
xcopy "%currentDirectory%\itickets.lnk" "C:\Users\Public\Desktop\" /Y
cd\
ECHO ###########
@echo off
pushd \\aest-repo1\paquetes
cd Acceso Directo\Acceso Directo Teco XP
set "currentDirectory=%cd%
xcopy "%currentDirectory%\TecoXP.ico" "C:\Windows\" /Y
xcopy "%currentDirectory%\Teco XP.url" "C:\Users\Public\Desktop\" /Y
cd\
pause
goto:menu


:COPY_PERFIL

@echo off
c:
set /p Unidad=Ingrese la unidad:
set /p UsuarioA=Ingresa el usuario anterior: 
set /p UsuarioN=Ingresa el usuario nuevo: 
set UsuC=C:\Users
robocopy %Unidad%:\Users\%UsuarioA%\Documents %UsuC%\%UsuarioN%\Documents /E /R:0 /W:0
robocopy %Unidad%:\Users\%UsuarioA%\Desktop %UsuC%\%UsuarioN%\Desktop /E /R:0 /W:0
robocopy %Unidad%:\Users\%UsuarioA%\Favorites %UsuC%\%UsuarioN%\Favorites /E  /R:0 /W:0
robocopy %Unidad%:\Users\%UsuarioA%\Downloads %UsuC%\%UsuarioN%\Downloads /E /R:0 /W:0
robocopy %Unidad%:\Users\%UsuarioA%\Pictures %UsuC%\%UsuarioN%\Pictures /E /R:0 /W:0
robocopy %Unidad%:\Users\%UsuarioA%\AppData\Roaming\Centrify %UsuC%\%UsuarioN%\AppData\Roaming\Centrify /E /R:0 /W:0
robocopy "%Unidad%:\Users\%UsuarioA%\AppData\Local\Google\Chrome\User Data\Default" "%UsuC%\%UsuarioN%\AppData\Local\Google\Chrome\User Data\Default" /E /R:0 /W:0 /XD "%Unidad%:\Users\%UsuarioA%\AppData\Local\Google\Chrome\User Data\Default\Service Worker" /XD "%Unidad%:\Users\%UsuarioA%\AppData\Local\Google\Chrome\User Data\Default\Cache" /XD "%Unidad%:\Users\%UsuarioA%\AppData\Local\Google\Chrome\User Data\Default\Code Cache"
if errorlevel 4 echo COPIA CON ERRORES & goto bad
if errorlevel 1 echo COPIA EXITOSA & goto ok

:bad
msg * COPIA CON ERRORES
pause
goto:menu

:ok 
msg * COPIA EXITOSA
pause
goto:menu


:DESHABILITAR SYSMAIN Y EXPERENCIA DEL USUARIO

@echo off
sc stop "Sysmain"
timeout /t 5 /nobreak
sc stop "DiagTrack"
timeout /t 5 /nobreak
sc config "Sysmain" start= disabled
sc config "DiagTrack" start= disabled
pause
goto:menu

:GoogleE

@echo off
pushd \\aest-repo1\paquetes
cd "Google Earth"
Google_Earth.msi
cd\
pause
goto:menu

:Viewfinity

@echo off
pushd \\aest-repo1\paquetes
cd "Viewfinity Agent"
@echo off
If Not Exist %WINDIR%\SysWow64 GoTo 32Bit
:64Bit
msiexec.exe /i CyberArkEPMAgentSetup_6.3.1.440X64.msi /quiet /norestart /L*v c:\windows\temp\viewfinity64.log
GOTO EXIT
:32Bit
msiexec.exe /i CyberArkEPMAgentSetup_6.3.1.440.msi /quiet /norestart /L*v c:\windows\temp\viewfinity32.log
:EXIT
cd\
pause
goto:menu

:SAPsinconex
@echo off
pushd \\aest-repo1\paquetes
cd SAP 7.70\Customizado
SAP_GUI_770_20210203_1329.exe
cd\
pause
goto:menu


:BentleyView
@echo off
pushd \\aest-repo1\paquetes
cd Bentley View
Setup.exe
cd\
pause
goto:menu

:COPY_CARPETAS

@echo off
setlocal
set /p Unidad=Ingrese la unidad:
set /p DirOrigen=Directorio origen: 
set /p DirDestino=Directorio destino: 
set UsuC=C:\
C:\ 
MD %DirDestino%

:copyFiles
echo Ejecutando Robocopy para copiar archivos desde "%Unidad%:\%DirOrigen%" a "%UsuC%\%destinationFolder%"
robocopy %Unidad%:\%DirOrigen%\ %UsuC%\%DirDestino% /E /R:0 /W:0

echo Desea copiar mas archivos? (Si/No)
set /p choice=
if /i "%choice%"=="si" (
    set /p Unidad=Ingrese la unidad:
    set /p DirOrigen=Directorio origen: 
    set /p DirDestino=Directorio destino: 
    goto copyFiles
) else (
    echo COPIA DE ARCHIVOS EXITOSA.
)

endlocal
pause
goto:menu

:Vmware
pushd \\aest-repo1\paquetes
Cd VMware\VMware Client\VMware Client Windows\Prod
start /Wait VMware-Horizon-Client-2103-8.2.0-17759012.exe /silent /norestart ADDLOCAL=USB AUTO_UPDATE_ENABLED=0 DESKTOP_SHORTCUT=1 VDM_Server=vdicorp.telecom.com.ar RDPCHOICE=0
REG ADD "HKLM\SOFTWARE\WOW6432Node\VMware, Inc.\VMware VDM\Client" /v MRBroker /D vditeco.telecom.com.ar /f
cd\
pause
goto:menu

:Vent
@echo off
start cmd /k "pushd \\aest-repo1\paquetes"
pause
goto:menu

:SSD
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-a2a1-449c-9680-f91c70521c60" /v Attributes /t REG_DWORD /d 2
pause
goto:menu


pause
cls
goto :menu

:EXIT
exit
*****************************************************************


