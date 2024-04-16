$Host.UI.RawUI.ForegroundColor = "Green"
# Función para instalar SAP GUI V8 y configurar conexiones
function InstalarSAPGUIV8 {
    $url = "\\aest-repo1\paquetes\SAP GUI V8 win64"
    Set-Location $url
    Start-Process -FilePath ".\SAPGUIv8_64bits_20230606_1703.exe" -Wait
    Start-Process -FilePath ".\GUI800_2-80006342.EXE" -Wait

    $UsuarioN = Read-Host "Ingresa el usuario"
    $ruta = "C:\Users\$UsuarioN\AppData\Roaming\SAP\Common"
    $url = "\\aest-repo1\paquetes\SAP GUI V8 win64\SAPFILES"

    New-Item -Path $ruta -ItemType Directory -Force
    Set-Location $ruta

    Copy-Item "$url\saplogon.ini" -Destination $ruta -Force
    Copy-Item "$url\SAPUILandscape.xml" -Destination $ruta -Force
    Copy-Item "$url\SAPUILandscapeGlobal.xml" -Destination $ruta -Force

    Read-Host "Presiona Enter para continuar..."
}

# Función para instalar GIRAFE
function InstalarGIRAFE {
    $url = "\\aest-repo1\paquetes\girafe\girafe"
    Set-Location $url
    cscript.exe Install.vbs
    Set-Location "Girafe"
    Start-Process .\Girafe_Sesiones.EXE
    Read-Host "Presiona Enter para continuar..."
}

# Función para instalar OpenSmartFlex
function InstalarOpenSmartFlex {
    $url = "\\aest-repo1\paquetes\Open SmartFlex 7.5\Open SmartFlex 7.5 - x86x64\x64"
    Set-Location $url
    Start-Process .\OSFSetup.exe -ArgumentList "/S" -Wait
    icacls "C:\Program Files (x86)\OpenSystems" /q /c /t /grant TODOS:(OI)(CI)F
    Start-Process "7z.exe" -ArgumentList "x 'OpenSmartFlex-patch.7z' -o'C:\Program Files (x86)\OpenSystems\OpenSmartFlex' -y" -Wait
    Copy-Item ".\WOIN3.dll" -Destination "C:\Program Files (x86)\OpenSystems\OpenSmartFlex" -Force
    Read-Host "Presiona Enter para continuar..."
}

# Función para instalar Condis
function InstalarCondis {
    $url = "\\aest-repo1\paquetes\CONDIS Client C12 64 BITS NI - NEW\INSTALL"
    Set-Location $url
    Start-Process .\CONDIS Client C12 64 BITS NI.EXE -Wait

    $url = "\\aest-repo1\paquetes\Condis Client C12 NRED\Install"
    Set-Location $url
    Start-Process .\Condis Client C12 NRED.EXE -Wait

    Read-Host "Presiona Enter para continuar..."
}

# Función para instalar Onefield
function InstalarOnefield {
    $url = "\\aest-repo1\paquetes\CableVision - Aplicaciones\CSG Onefield - Update 28-03-21"
    if (!(Test-Path "C:\CSGSystems")) {
        Set-Location $url
        Start-Process msiexec.exe -ArgumentList "/i 'One Field.msi' /qn ALLUSERS=2" -Wait
    }

    $url = "\\aest-repo1\paquetes"
    Set-Location $url
    cscript.exe "Install_Update.vbs"
    icacls "C:\CSGSystems" /q /c /t /grant USUARIOS:(OI)(CI)M

    Read-Host "Presiona Enter para continuar..."
}

# Función para instalar Office 365
function InstalarOffice365 {
    $url = "\\aest-repo1\paquetes\Microsoft Office 365\Semiannual64"
    Set-Location $url
    .\ConfigurationNueva64_con_uninstall_office2016.bat
    Read-Host "Presiona Enter para continuar..."
}

# # Función para instalar accesos
function InstalarAccesos {
    $url = "\\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\SAP_Concur-acceso"
    $url1 = "\\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\SMART-acceso"
    $url2 = "\\aest-repo1\paquetes\Acceso Directo\Acceso Directo Tapps (nuevo)"
    $url3 = "\\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\Acceso Directo Itickets"
    $url4 = "\\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\SAP_Concur-acceso\x64"
    $url5 = "\\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\SMART-acceso\x64"
    $url6 = "\\aest-repo1\paquetes\Acceso Directo\Acceso Directo Teco XP"
    $rut2 = "C:\Windows\"
    $rut3 = "C:\Users\Public\Desktop\"
    Write-Host "SAPConcur"
    Copy-Item "$url\SapConcur.ico" -Destination $rut2 -Force
    Copy-Item "$url4\SAP Concur.lnk" -Destination $rut3 -Force
    Write-Host "Smart"
    Copy-Item "$url1\Smart.ico" -Destination $rut2 -Force
    Copy-Item "$url5\Smart.lnk" -Destination $rut3 -Force
    Write-Host "Tapps"
    Copy-Item "$url2\Tapps.ico" -Destination $rut2 -Force
    Copy-Item "$url2\Tapps.lnk" -Destination $rut3 -Force
    Write-Host "Itickets"
    Copy-Item "$url3\itickets.ico" -Destination $rut2 -Force
    Copy-Item "$url3\itickets.lnk" -Destination $rut3 -Force
    Write-Host "TecoXP"
    Copy-Item "$url6\TecoXP.ico" -Destination $rut2 -Force
    Copy-Item "$url6\Teco XP.url" -Destination $rut3 -Force
    Read-Host "Presione cualquier tecla para continuar..."
    }  

    # Función para copiar perfil de usuario
function CopyPerfil {
    # Solicitar entrada del usuario
    $Unidad = Read-Host "Ingrese la unidad disco anterior:"
    $UsuarioA = Read-Host "Ingresa el usuario anterior:"
    $UsuarioN = Read-Host "Ingresa el usuario nuevo:"
    $UsuC = "C:\Users"
    try {
        Copy-Item "$Unidad\Users\$UsuarioA\Desktop" -Destination "$UsuC\$UsuarioN\Desktop" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\Documents" -Destination "$UsuC\$UsuarioN\Documents" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\Downloads" -Destination "$UsuC\$UsuarioN\Downloads" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\Pictures" -Destination "$UsuC\$UsuarioN\Pictures" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\Favorites" -Destination "$UsuC\$UsuarioN\Favorites" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\AppData\Roaming\Centrify" -Destination "$UsuC\$UsuarioN\AppData\Roaming\Centrify" -Force -Recurse -Container
        Copy-Item "$Unidad\Users\$UsuarioA\AppData\Local\Google\Chrome\User Data\Default" -Destination "$UsuC\$UsuarioN\AppData\Local\Google\Chrome\User Data\Default" -Force -Recurse -Container -Exclude "$Unidad\Users\$UsuarioA\AppData\Local\Google\Chrome\User Data\Default\Service Worker" , "$Unidad\Users\$UsuarioA\AppData\Local\Google\Chrome\User Data\Default\Cache" , "$Unidad\Users\$UsuarioA\AppData\Local\Google\Chrome\User Data\Default\Code Cache"
        # Mostrar mensaje de copia exitosa
        Write-Host "Copia exitosa"
    }
    catch {
        # Mostrar mensaje de copia con errores
        Write-Host "Copia con errores"
    }
    Read-Host "Presiona Enter para continuar..."
}

# Función para mostrar el menú
function MostrarMenu {
    do {
        Clear-Host
        Write-Host ""
        Write-Host "*********************************  PROCESSULTRA  *******************************" -ForegroundColor White
        Write-Host "
        Write-Host "                      1. Instala SAPLogon y crea conexiones"
        Write-Host "                      2. Instala GIRAFE"
        Write-Host "                      3. Instala OpenSmart"
        Write-Host "                      4. Instala accesos"
        Write-Host "                      5. Instala Onefield"
        Write-Host "                      6. OFFICE 365"
        Write-Host "                      7. Copy perfil"
        Write-Host "                      99. EXIT"
        Write-Host " 
        Write-Host "********************************************************************************" -ForegroundColor White
        Write-Host ""

        $opcion = Read-Host "Elige una opción"

        switch ($opcion) {
            '1' { InstalarSAPGUIV8 }
            '2' { InstalarGIRAFE }
            '3' { InstalarOpenSmartFlex }
            '4' { InstalarAccesos }
            '5' { InstalarOnefield }
            '6' { InstalarOffice365 }
            '7' { CopyPerfil }
            '99' { exit }
            default { Write-Host "Opción no válida. Por favor, selecciona una opción válida." }
        }
    } while ($true)
}

# Llama a la función del menú
MostrarMenu


