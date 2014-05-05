REM Creates installer .exe file.
REM Copy it to top-level directory before run!

SET QTIFW_DIR=C:\Qt\QtIFW-1.5.0\bin
SET PACKAGE_DIR=qtifw
SET MainPackage=com.nonogram.NonogramEditor
SET PortableBundleName=NonogramBundle
SET InstallerName=NonogramEditorSetup.exe


DEL /Q %PACKAGE_DIR%\packages\%MainPackage%\data\bundle.7z

:COLLECT
cd %PortableBundleName%
if errorlevel 1 goto :EXIT
for /D %%i in (*) DO call :concat %%i
for %%i in (*) DO call :concat %%i
%QTIFW_DIR%\archivegen.exe "..\%PACKAGE_DIR%\packages\%MainPackage%\data\bundle.7z" %FILES_LIST%
if errorlevel 1 goto :EXIT
cd ..

%QTIFW_DIR%\binarycreator.exe --offline-only --template %QTIFW_DIR%\installerbase --packages %PACKAGE_DIR%\packages --config %PACKAGE_DIR%\config\config.xml %InstallerName%
goto :CLEANUP_AND_EXIT

:CONCAT
SET FILES_LIST=%FILES_LIST% %1
goto :EXIT

:CLEANUP_AND_EXIT
DEL /Q %PACKAGE_DIR%\packages\%MainPackage%\data\bundle.7z

:EXIT
