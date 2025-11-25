@echo off
SETLOCAL
chcp 65001 >nul
cls

echo.
echo ========================================
echo   Instalador de Gradle
echo ========================================
echo.
echo Este script instalara Gradle 8.5 en:
echo   C:\Gradle\gradle-8.5
echo.
echo El proceso tomara aproximadamente 1-2 minutos.
echo.
pause

echo.
echo Ejecutando instalador de PowerShell...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0instalar-gradle.ps1"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   Instalacion completada!
    echo ========================================
    echo.
    echo IMPORTANTE: Cierra esta ventana y abre una NUEVA terminal
    echo para que los cambios de PATH surtan efecto.
    echo.
    echo Luego ejecuta: 2-GENERAR-PDF.bat
    echo.
) else (
    echo.
    echo Hubo un problema con la instalacion.
    echo.
)

pause
