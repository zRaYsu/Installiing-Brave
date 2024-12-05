@echo off
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Este script requiere privilegios de administrador.
    echo Por favor, ejecute como administrador.
    pause
    exit /b 1
)

set "TEMP_DIR=%TEMP%"
set "INSTALLER=%TEMP_DIR%\brave_installer.exe"

echo Descargando Brave...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://laptop-updates.brave.com/latest/winx64', '%INSTALLER%')"
if %errorLevel% neq 0 (
    echo Error al descargar Brave.
    pause
    exit /b 1
)

echo Verificando si Brave ya está instalado...
powershell -Command "Get-Process brave -ErrorAction SilentlyContinue" >nul
if %errorLevel% equ 0 (
    echo Brave ya está instalado.
    echo No se realizará ninguna acción.
    pause
    exit /b 0
)

echo Instalando Brave...
start /wait "" "%INSTALLER%"

echo Verificando navegadores abiertos...
for %%B in (chrome.exe firefox.exe msedge.exe opera.exe) do (
    tasklist | find /i "%%B" >nul
    if %errorLevel% equ 0 (
        echo Cerrando %%B...
        taskkill /f /im %%B
    )
)

del "%INSTALLER%" 2>nul

echo Abriendo Brave y navegando a PornHub...
timeout /t 1 /nobreak >nul
start brave https://www.pornhub.com/

echo Proceso completado
pause

REM bY Kryxuss
