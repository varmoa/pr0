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

# Función para instalar accesos
function InstalarAccesos {
    $acceso1 = \\aest-repo1\paquetes\UPGRADE y MANTENIMIENTO\
    Set-Location $acceso1
     .\SAP_Concur-acceso
    cscript.exe Install.vbs
    Write-Host "##########"
    Set-Location $acceso
     .\SMART-acceso
    cscript.exe Install.vbs
     Read-Host "Presiona Enter para continuar..."
    }  

# Función para mostrar el menú
function MostrarMenu {
    do {
        Clear-Host
        Write-Host "-------------##########------------"
        Write-Host ""
        Write-Host "1. Instala SAPLogon y crea conexiones"
        Write-Host "2. Instala GIRAFE"
        Write-Host "3. Instala OpenSmart"
        Write-Host "4. Instala accesos"
        Write-Host "5. Instala Onefield"
        Write-Host "6. OFFICE 365"
        Write-Host "7. Todavia nada"
        Write-Host "99. EXIT"
        Write-Host ""

        $opcion = Read-Host "Elige una opción"

        switch ($opcion) {
            '1' { InstalarSAPGUIV8 }
            '2' { InstalarGIRAFE }
            '3' { InstalarOpenSmartFlex }
            '4' { InstalarAccesos }
            '5' { InstalarOnefield }
            '6' { InstalarOffice365 }
            '99' { exit }
            default { Write-Host "Opción no válida. Por favor, selecciona una opción válida." }
        }
    } while ($true)
}

# Llama a la función del menú
MostrarMenu
