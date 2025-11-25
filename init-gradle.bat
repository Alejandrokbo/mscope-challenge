@echo off
SETLOCAL
chcp 65001 >nul
cls

echo.
echo ========================================
echo   Inicializando Proyecto Gradle
echo ========================================
echo.

REM Verificar Java
java -version 2>&1 | findstr /i "version" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java no esta instalado
    echo Descarga Java desde: https://adoptium.net/
    pause
    exit /b 1
)

echo [√] Java detectado
java -version 2>&1 | findstr /i "version"
echo.

echo [1/3] Descargando Gradle Wrapper...

if not exist "gradle\wrapper" mkdir gradle\wrapper

REM Descargar gradle-wrapper.jar
powershell -Command "& {Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/gradle/gradle/master/gradle/wrapper/gradle-wrapper.jar' -OutFile 'gradle\wrapper\gradle-wrapper.jar'}"

if not exist "gradle\wrapper\gradle-wrapper.jar" (
    echo [ERROR] No se pudo descargar gradle-wrapper.jar
    pause
    exit /b 1
)

echo [√] Gradle Wrapper descargado
echo.

echo [2/3] Creando scripts gradlew...

REM Crear gradlew.bat
(
echo @rem
echo @rem Copyright 2015 the original author or authors.
echo @rem
echo @if "%%OS%%"=="Windows_NT" setlocal
echo.
echo set DIRNAME=%%~dp0
echo if "%%DIRNAME:~-1%%"=="\" set DIRNAME=%%DIRNAME:~0,-1%%
echo.
echo set APP_BASE_NAME=%%~n0
echo set APP_HOME=%%DIRNAME%%
echo.
echo set JAVA_EXE=java.exe
echo if defined JAVA_HOME goto findJavaFromJavaHome
echo.
echo set JAVA_EXE=java.exe
echo %%JAVA_EXE%% -version ^>NUL 2^>^&1
echo if "%%ERRORLEVEL%%" == "0" goto execute
echo.
echo echo.
echo echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo echo.
echo goto fail
echo.
echo :findJavaFromJavaHome
echo set JAVA_HOME=%%JAVA_HOME:"=%%
echo set JAVA_EXE=%%JAVA_HOME%%/bin/java.exe
echo.
echo :execute
echo set CLASSPATH=%%APP_HOME%%\gradle\wrapper\gradle-wrapper.jar
echo.
echo "%%JAVA_EXE%%" -classpath "%%CLASSPATH%%" org.gradle.wrapper.GradleWrapperMain %%*
echo.
echo :end
echo if "%%ERRORLEVEL%%"=="0" goto mainEnd
echo.
echo :fail
echo exit /b 1
echo.
echo :mainEnd
echo if "%%OS%%"=="Windows_NT" endlocal
) > gradlew.bat

echo [√] gradlew.bat creado
echo.

echo [3/3] Probando Gradle...
echo.

call gradlew.bat tasks --quiet

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   √ Proyecto Gradle inicializado!
    echo ========================================
    echo.
    echo Comandos disponibles:
    echo   gradlew generatePdf    - Generar PDF completo
    echo   gradlew openPdf        - Generar y abrir PDF
    echo   gradlew tasks          - Ver todas las tareas
    echo.
    echo Para generar el PDF ahora:
    echo   gradlew generatePdf
    echo.
) else (
    echo.
    echo [ERROR] Hubo un problema al inicializar Gradle
    echo.
)

pause
