@echo off
REM Double-clic : met a jour le projet et copie l'indicateur Pine dans le presse-papiers.
cd /d "%~dp0"
title MISE A JOUR PINE
git pull
powershell -NoProfile -Command "Get-Content 'pine\plan_xau_2sens.pine' -Raw -Encoding UTF8 | Set-Clipboard"
echo.
echo ================================================================
echo  Code de l'indicateur copie. Maintenant, dans TradingView :
echo   Editeur Pine, script "chatgpt", clic dans le code,
echo   Ctrl+A, Ctrl+V, Ctrl+S.
echo  Ne copiez rien d'autre avant d'avoir colle.
echo ================================================================
pause
