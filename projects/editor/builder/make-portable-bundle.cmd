REM Makes folder with portable application bundle.

SET QtSDKPath=C:\Qt\Qt5.2.1\5.2.1\mingw48_32\bin
SET BundleDir=NonogramBundle
SET BuildDir=..\build-release
SET AppName=NonogramEditor.exe
SET QmlResourceDir=..\NonogramEditor\qml
SET OldSystemPath=%PATH%

RD /S /Q %BundleDir%
MKDIR %BundleDir%
COPY /Y "%BuildDir%\release\%AppName%" "%BundleDir%\%AppName%"
COPY /Y "%QtSDKPath%\libgcc_s_dw2-1.dll" "%BundleDir%\libgcc_s_dw2-1.dll"
COPY /Y "%QtSDKPath%\libstdc++-6.dll" "%BundleDir%\libstdc++-6.dll"
COPY /Y "%QtSDKPath%\libwinpthread-1.dll" "%BundleDir%\libwinpthread-1.dll"
PATH=%PATH%;%QtSDKPath%
windeployqt --qmldir %QmlResourceDir% "%BundleDir%\%AppName%"
PATH=%OldSystemPath%

@echo Removing debug and unused libraries...
@echo off

CD %BundleDir%

DEL /Q "accessible\qtaccessiblequickd.dll"
DEL /Q "accessible\qtaccessiblewidgetsd.dll"

DEL /Q "bearer\qgenericbearerd.dll"
DEL /Q "bearer\qnativewifibearerd.dll"

DEL /Q "iconengines\qsvgicond.dll"

DEL /Q "imageformats\qgifd.dll"
DEL /Q "imageformats\qicod.dll"
DEL /Q "imageformats\qjpegd.dll"
DEL /Q "imageformats\qmngd.dll"
DEL /Q "imageformats\qsvgd.dll"
DEL /Q "imageformats\qtgad.dll"
DEL /Q "imageformats\qtiffd.dll"
DEL /Q "imageformats\qwbmpd.dll"

DEL /Q "mediaservice\dsengined.dll"
DEL /Q "mediaservice\qtmedia_audioengined.dll"

DEL /Q "playlistformats\qtmultimedia_m3ud.dll"

DEL /Q "qmltooling\qmldbg_qtquick2d.dll"
DEL /Q "qmltooling\qmldbg_tcpd.dll"

DEL /Q "Qt\labs\folderlistmodel\qmlfolderlistmodelplugind.dll"
DEL /Q "QtMultimedia\declarative_multimediad.dll"
DEL /Q "QtQuick.2\qtquick2plugind.dll"
DEL /Q "QtQuick\Controls\qtquickcontrolsplugind.dll"
DEL /Q "QtQuick\Dialogs\dialogplugind.dll"
DEL /Q "QtQuick\Dialogs\Private\dialogsprivateplugind.dll"
DEL /Q "QtQuick\Layouts\qquicklayoutsplugind.dll"
DEL /Q "QtQuick\PrivateWidgets\widgetsplugind.dll"
DEL /Q "QtQuick\Window.2\windowplugind.dll"
CD ..
