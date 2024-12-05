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

echo Instalando Brave...
start /wait "" "%INSTALLER%"

echo Verificando Firefox...
tasklist | find /i "firefox.exe" >nul
if %errorLevel% equ 0 (
    echo Cerrando Firefox...
    taskkill /f /im firefox.exe
)

del "%INSTALLER%" 2>nul
echo Proceso completado
pause

REM bY Kryxuss