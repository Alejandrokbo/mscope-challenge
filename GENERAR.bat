@echo off
SETLOCAL EnableDelayedExpansion
chcp 65001 >nul
cls

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║  Generador de PDF Empresarial - Gradle + PlantUML        ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Verificar Java
java -version 2>&1 | findstr /i "version" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [X] Java no esta instalado
    echo.
    echo Descarga Java 17 desde: https://adoptium.net/
    pause
    exit /b 1
)

echo [√] Java instalado:
java -version 2>&1 | findstr /i "version"
echo.

REM Verificar Gradle
where gradle >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [√] Gradle instalado
    gradle -version | findstr "Gradle"
    echo.
    echo Generando PDF con Gradle...
    echo.
    gradle generatePdf
    goto END_SUCCESS
)

echo [!] Gradle no encontrado en PATH
echo.
echo ════════════════════════════════════════════════════════════
echo   OPCION 1: Instalar Gradle (Recomendado)
echo ════════════════════════════════════════════════════════════
echo.
echo Con Chocolatey (Windows):
echo   choco install gradle
echo.
echo Con SDKMAN (Linux/Mac):
echo   sdk install gradle
echo.
echo Manual:
echo   1. Descargar: https://gradle.org/releases/
echo   2. Extraer a C:\Gradle
echo   3. Agregar C:\Gradle\bin al PATH
echo.
echo ════════════════════════════════════════════════════════════
echo   OPCION 2: Usar metodos alternativos
echo ════════════════════════════════════════════════════════════
echo.
echo Ver archivo: ..\pdf-generator\GENERAR-ONLINE.md
echo.
echo Opciones rapidas:
echo   - CloudConvert: https://cloudconvert.com/md-to-pdf
echo   - Pandoc: Instalar y usar generate-pdf-pandoc.bat
echo.

:END_SUCCESS
if exist "build\Plan_Tech_Lead_mscope.pdf" (
    echo.
    echo ════════════════════════════════════════════════════════════
    echo   √ PDF generado exitosamente!
    echo ════════════════════════════════════════════════════════════
    echo.
    echo   Ubicación: build\Plan_Tech_Lead_mscope.pdf
    echo.
    for %%A in (build\Plan_Tech_Lead_mscope.pdf) do (
        set FILESIZE=%%~zA
        set /a FILESIZEKB=!FILESIZE!/1024
        set /a FILESIZEMB=!FILESIZEKB!/1024
        echo   Tamaño: !FILESIZEMB! MB
    )
    echo.
    echo   Abriendo PDF...
    start "" "build\Plan_Tech_Lead_mscope.pdf"
    echo.
    echo ════════════════════════════════════════════════════════════
)

pause
