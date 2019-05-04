
Title Plan de nommage PC DIRED 2016 
@ECHO OFF
REM Source Blogmotion.fr
:CHECKPERMISSION
        ATTRIB %windir%\system32 -h | FINDSTR /I "system32" >nul
        IF %ERRORLEVEL% NEQ 1 (
                ECHO.
                ECHO Ce script doit etre lance en Administrateur.
                ECHO.
                GOTO FIN
        )

@echo off

REM ###### plan de renommage pc/portable/all-in-one - DIRED 2016 ###### 
rem script de renommage automatique des pc

rem V1.03


rem CALPETARD Olivier - AMI - lycee Antoine ROUSSIN
rem 0692 02 25 06


IF EXIST D:\USB.txt set USB=D:
IF EXIST E:\USB.txt set USB=E:
IF EXIST F:\USB.txt set USB=F:
IF EXIST G:\USB.txt set USB=G:
IF EXIST H:\USB.txt set USB=H:
IF EXIST I:\USB.txt set USB=I:
IF EXIST J:\USB.txt set USB=J:
IF EXIST K:\USB.txt set USB=K:
IF EXIST L:\USB.txt set USB=L:
IF EXIST M:\USB.txt set USB=M:
IF EXIST N:\USB.txt set USB=N:
IF EXIST O:\USB.txt set USB=O:
IF EXIST P:\USB.txt set USB=P:


REM ###### a modifier selon l'établissement ###### 
rem configuration code etablissement Lxx et mdp administrateur local des pc

set etab=Xxx
set password_adm=xxxxxx

REM ######------######------######------######------######

@echo off
setlocal
@for %%n in (%0) do set fold=%%~dpn
:menu
echo ------------------------------------------------
echo -- Plan de nommage REGION REUNION DIRED 2016  --
echo ------------------------------------------------
echo.
echo 1.renomer le poste
echo 2.joineole
echo q.Quitter
echo.



set /p reponse="Quel est votre choix ?"

If /i "%reponse%"=="1" goto :controle
If /i "%reponse%"=="2" goto :Joineole
If /i "%reponse%"=="q" goto :fin
CLS

ECHO ============reponse invalide============
ECHO -------------------------------------
ECHO Selectionne un nombre 1 ou 2
echo Menu [1-2] ou selectionne 'Q' pour quitter.
ECHO -------------------------------------
ECHO ======Appuie sur une touche pour continuer======

PAUSE > NUL
GOTO menu

:controle

if exist C:\PCNAME.txt (echo le pc est deja renome) else goto type

pause
goto menu 


:type

rem enregistrement de lancien nom du pc
set oldname=%computername%
rem suppression du xml wpkg pour reprendre a zero sans desinstaler
DEL /F /Q "%WINDIR%\System32\wpkg.xml

echo ------------------------------------------------
echo -- type de PC  --
echo ------------------------------------------------
echo.
echo 1.c'est un PC fixe
echo 2.c'est un Portable
echo 3.c'est un all-in-one
echo 4.retour au menu de depart
echo q.Quitter le script

echo.
set /p reponse1="C'est un PC fixe ou un portable ou un all-in-one ?"

If /i "%reponse1%"=="1" goto :pcfixe
If /i "%reponse1%"=="2" goto :portable
If /i "%reponse1%"=="3" goto :aio
If /i "%reponse1%"=="4" goto :menu
If /i "%reponse1%"=="Q" goto :fin

cls

ECHO ============reponse invalide============
ECHO -------------------------------------
ECHO Selectionne un nombre 1,2,3 ou 4
echo Menu [1-4] ou selectionne 'Q' pour quitter.
ECHO -------------------------------------
ECHO ======Appuie sur une touche pour continuer======

PAUSE > NUL
GOTO type

:joineole
cls
echo phase integredom

start /wait %USB%\joineole.exe
cls

goto :menu

:pcfixe
cls
echo pc fixe
@echo off
setlocal enabledelayedexpansion

FOR /F %%i IN (compteur_ord.txt) DO SET /A x=%%i+1
echo %x% > compteur_ord.txt
echo %x%

call :printVal 5 %x%
goto :EOF

:printVal
for /L %%i in (1,1,%1) do set zero=0!zero!
set var=%zero%%2
set var=!var:~-%1!
echo %var%
echo %etab%-ORD%var% > nom_ord.txt
pause
::affecter PCNAME avec la valeur du compteur ORD
set /p PCNAME= < nom_ord.txt
cls
goto :change

:portable
cls
echo portable
@echo off
setlocal enabledelayedexpansion

FOR /F %%i IN (compteur_por.txt) DO SET /A x=%%i+1
echo %x% > compteur_por.txt
echo %x%

call :printVal 5 %x%

goto :EOF

:printVal
for /L %%i in (1,1,%1) do set zero=0!zero!
set var=%zero%%2
set var=!var:~-%1!
echo %var%
echo %etab%-POR%var% > nom_por.txt
pause
::affecter PCNAME avec la valeur du compteur POR
set /p PCNAME= < nom_por.txt
cls
goto :change
goto :menu

:aio
cls
echo All-in-one
@echo off
setlocal enabledelayedexpansion

FOR /F %%i IN (compteur_aio.txt) DO SET /A x=%%i+1
echo %x% > compteur_aio.txt
echo %x%

call :printVal 5 %x%

goto :EOF

:printVal
for /L %%i in (1,1,%1) do set zero=0!zero!
set var=%zero%%2
set var=!var:~-%1!
echo %var%
echo %etab%-AIO%var% > nom_aio.txt
pause
::affecter PCNAME avec la valeur du compteur POR
set /p PCNAME= < nom_aio.txt
cls
goto :change
goto :menu

:change

echo localisation du PC
echo.
set /p salle="Quel est la salle ?"
echo %salle%


REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v Hostname /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v "NV Hostname" /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\ControlSet001\services\LanmanServer\Parameters\ /v "srvcomment" /t REG_SZ /d %salle% /f
@echo off
echo %PCNAME% > c:/pcname.txt
echo %salle% >> c:/pcname.txt
echo %oldname%,%pcname%,%salle%>>liste_pc.csv
mkdir %salle%
echo %pcname%>>%salle%/esu_tab.csv

rem autologin 1 fois

REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f

REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d Administrateur /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d %password_adm% /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoLogonCount /t REG_DWORD /d 1 /f

rem install fusioninventory-agent

rem cscript \\scribe\netlogon\dsi\exec\CR974-AgentFusionInventoryInstallateur-v1.2.cmd

rem force inventaire
:force
rem xcopy force_fusion.bat c:\
rem schtasks /create /sc ONSTART /tn force_inventaire /tr "c:\force_fusion.bat" /ru "system"

c:\RDPWrap\install.bat

echo redemarrage du pc
shutdown -r -f -t 2

echo.
echo.
pause
:fin
endlocal
exit
