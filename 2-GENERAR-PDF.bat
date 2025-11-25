@echo off
SETLOCAL EnableDelayedExpansion
chcp 65001 >nul
cls

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║  Generador de PDF - Gradle + PlantUML + Asciidoctor      ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Verificar Java
echo [1/4] Verificando Java...
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java no encontrado
    echo Instala Java desde: https://adoptium.net/
    pause
    exit /b 1
)
java -version 2>&1 | findstr "version"
echo.

REM Verificar Gradle
echo [2/4] Verificando Gradle...
gradle -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Gradle no encontrado
    echo.
    echo Si acabas de instalar Gradle:
    echo   1. Cierra esta ventana
    echo   2. Abre una NUEVA terminal
    echo   3. Ejecuta este script de nuevo
    echo.
    echo Si no has instalado Gradle:
    echo   Ejecuta: 1-INSTALAR-GRADLE.bat
    echo.
    pause
    exit /b 1
)
gradle -version 2>&1 | findstr "Gradle"
echo.

echo [3/4] Generando PDF con Gradle...
echo ════════════════════════════════════════════════════════════
echo.
echo Este proceso incluye:
echo   - Descarga de PlantUML (si es necesario)
echo   - Generacion de 5 diagramas UML
echo   - Conversion de AsciiDoc a PDF
echo   - Aplicacion de tema personalizado
echo.
echo Puede tomar 2-5 minutos la primera vez...
echo.

REM Ejecutar Gradle
gradle generatePdf

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ════════════════════════════════════════════════════════════
    echo [ERROR] Hubo un problema al generar el PDF
    echo ════════════════════════════════════════════════════════════
    echo.
    echo Verifica los mensajes de error arriba.
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════════════════════
echo [4/4] Verificando PDF generado...
echo ════════════════════════════════════════════════════════════
echo.

if exist "build\Plan_Tech_Lead_mscope.pdf" (
    for %%A in (build\Plan_Tech_Lead_mscope.pdf) do (
        set FILESIZE=%%~zA
        set /a FILESIZEKB=!FILESIZE!/1024
        set /a FILESIZEMB=!FILESIZEKB!/1024
    )

    echo [OK] PDF generado exitosamente!
    echo.
    echo   Ubicacion: build\Plan_Tech_Lead_mscope.pdf
    echo   Tamaño: !FILESIZEMB! MB (!FILESIZEKB! KB)
    echo.
    echo ════════════════════════════════════════════════════════════
    echo   Abriendo PDF...
    echo ════════════════════════════════════════════════════════════
    echo.

    start "" "build\Plan_Tech_Lead_mscope.pdf"

    echo.
    echo PDF abierto en tu visor predeterminado.
    echo.
    echo Tambien puedes encontrar:
    echo   - Diagramas PNG en: src\docs\asciidoc\images\
    echo   - Logs de build en: build\
    echo.
) else (
    echo [ERROR] El PDF no se genero
    echo.
    echo Verifica los logs arriba para mas detalles.
    echo.
)

pause
