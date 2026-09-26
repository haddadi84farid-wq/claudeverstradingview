@echo off
REM Double-clic : met a jour le projet, lance TradingView avec CDP, lance le lien Claude
REM et copie le prompt d'analyse dans le presse-papiers.
cd /d "%~dp0"
title DEMARRAGE TRADING

echo.
echo [1/4] Mise a jour du projet...
git pull

echo.
echo [2/4] TradingView avec CDP (port 9222)...
call :cdp
if not errorlevel 1 (
    echo       Deja actif.
    goto claude
)
tasklist /fi "imagename eq TradingView.exe" | find /i "TradingView.exe" >nul
if not errorlevel 1 (
    echo.
    echo  TradingView est ouvert SANS CDP : Claude ne pourra pas le lire.
    echo  Fermez TradingView completement (croix + icone pres de l'horloge, clic droit, Quitter^),
    echo  puis appuyez sur une touche ici.
    pause >nul
)
start "TRADINGVIEW CDP - NE PAS FERMER" /min powershell -NoProfile -ExecutionPolicy Bypass -NoExit -File "%~dp0scripts\launch_tv_debug.ps1" -Port 9222
echo       Attente de TradingView (60 s max)...
powershell -NoProfile -Command "for($i=0;$i -lt 30;$i++){try{$r=[Net.HttpWebRequest]::Create('http://127.0.0.1:9222/json/version');$r.Proxy=$null;$r.Timeout=2000;$r.GetResponse().Close();exit 0}catch{Start-Sleep 2}};exit 1"
if errorlevel 1 (
    echo.
    echo  ECHEC : TradingView ne repond pas sur le port 9222.
    echo  Regardez la fenetre "TRADINGVIEW CDP" dans la barre des taches.
    pause
    exit /b 1
)
echo       OK.

:claude
echo.
echo [3/4] Lien avec Claude...
powershell -NoProfile -Command "if(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like '*claude*remote-control*' -and $_.Name -ne 'powershell.exe' }){exit 0}else{exit 1}"
if not errorlevel 1 (
    echo       Deja ouvert.
) else (
    start "LIEN CLAUDE - NE PAS FERMER" /min /d "%~dp0" cmd /k claude.cmd remote-control
    echo       OK.
)

echo.
echo [4/4] Copie du prompt d'analyse dans le presse-papiers...
powershell -NoProfile -Command "Get-Content '1_TRADING\1_PROMPT_ANALYSE.txt' -Raw -Encoding UTF8 | Set-Clipboard"
echo       OK.

echo.
echo ================================================================
echo  PRET. Maintenant :
echo   1. TradingView : PEPPERSTONE:XAUUSD en 15 min.
echo   2. App Claude : Nouveau, environnement DESKTOP-H2QVCVL, mode Manuel.
echo   3. Ctrl+V dans la zone de message, puis Entree.
echo.
echo  Les fenetres "TRADINGVIEW CDP" et "LIEN CLAUDE" restent reduites :
echo  ne les fermez pas. Celle-ci peut etre fermee.
echo ================================================================
pause
exit /b 0

:cdp
powershell -NoProfile -Command "try{$r=[Net.HttpWebRequest]::Create('http://127.0.0.1:9222/json/version');$r.Proxy=$null;$r.Timeout=2000;$r.GetResponse().Close();exit 0}catch{exit 1}"
exit /b %errorlevel%
