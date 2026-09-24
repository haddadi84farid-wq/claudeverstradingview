# Launch TradingView Desktop on Windows with Chrome DevTools Protocol enabled.
# Supports classic installs (LOCALAPPDATA / Program Files) and the Microsoft Store (MSIX) package
# TradingView.Desktop_<version>_x64__n534cwy3pjxzj.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File scripts\launch_tv_debug.ps1 [-Port 9222]

param(
    [ValidateRange(1024, 65535)][int]$Port = 9222,
    [int]$TimeoutSec = 60
)

$ErrorActionPreference = 'Stop'
$cdpUrl = "http://localhost:$Port/json/version"

function Test-Cdp {
    try { return Invoke-RestMethod -Uri $cdpUrl -TimeoutSec 2 } catch { return $null }
}

# Already running with CDP on this port: nothing to do.
$info = Test-Cdp
if ($info) {
    Write-Host "CDP deja actif sur http://localhost:$Port ($($info.Browser))"
    exit 0
}

# Never force-close TradingView (unsaved work would be lost): ask the user instead.
# A TradingView instance started without CDP holds the single-instance lock, so a new launch
# would just focus it and the debugging port would never open.
if (Get-Process -Name TradingView -ErrorAction SilentlyContinue) {
    Write-Host "TradingView est deja ouvert sans CDP. Enregistrez votre travail, fermez TradingView"
    Write-Host "(y compris l'icone de la zone de notification), puis relancez ce script."
    exit 1
}

$tvExe = $null
$package = $null

# 1) Microsoft Store / MSIX install. The WindowsApps root is not listable (ACL), so wildcard
#    searches like "dir WindowsApps\TradingView*" fail: resolve the package through the Appx API.
try {
    $package = Get-AppxPackage -Name 'TradingView.Desktop' -ErrorAction SilentlyContinue |
        Sort-Object { [version]$_.Version } -Descending | Select-Object -First 1
} catch { $package = $null }

if ($package -and $package.InstallLocation) {
    $candidate = Get-ChildItem -LiteralPath $package.InstallLocation -Filter 'TradingView.exe' -Recurse -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($candidate) { $tvExe = $candidate.FullName }
}

# 2) Classic installers.
if (-not $tvExe) {
    $classic = @(
        "$env:LOCALAPPDATA\TradingView\TradingView.exe",
        "$env:ProgramFiles\TradingView\TradingView.exe",
        "${env:ProgramFiles(x86)}\TradingView\TradingView.exe"
    )
    $tvExe = $classic | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
}

if (-not $tvExe) {
    Write-Host "Erreur : TradingView introuvable (ni package Microsoft Store TradingView.Desktop, ni installation classique)."
    Write-Host "Lancement manuel : `"C:\chemin\TradingView.exe`" --remote-debugging-port=$Port"
    exit 1
}

$arg = "--remote-debugging-port=$Port"
Write-Host "TradingView trouve : $tvExe"
if ($package) { Write-Host "Package Store : $($package.PackageFullName)" }
Write-Host "Demarrage avec $arg ..."

$launched = $false
try {
    Start-Process -FilePath $tvExe -ArgumentList $arg -WorkingDirectory (Split-Path $tvExe)
    $launched = $true
} catch {
    Write-Host "Lancement direct refuse ($($_.Exception.Message))."
}

# Fallback for MSIX: run the exe inside the package's context (keeps package identity).
if (-not $launched -and $package) {
    try {
        $appId = (Get-AppxPackageManifest $package).Package.Applications.Application | Select-Object -First 1 -ExpandProperty Id
        Invoke-CommandInDesktopPackage -PackageFamilyName $package.PackageFamilyName -AppId $appId -Command $tvExe -Args $arg
        $launched = $true
    } catch {
        Write-Host "Invoke-CommandInDesktopPackage a echoue ($($_.Exception.Message))."
    }
}

if (-not $launched) { exit 1 }

Write-Host "Attente de CDP sur le port $Port ..."
$deadline = (Get-Date).AddSeconds($TimeoutSec)
while ((Get-Date) -lt $deadline) {
    Start-Sleep -Seconds 2
    $info = Test-Cdp
    if ($info) {
        Write-Host ""
        Write-Host "CDP pret : http://localhost:$Port"
        $info | ConvertTo-Json
        exit 0
    }
}

Write-Host "TradingView a demarre mais CDP ne repond pas sur le port $Port apres $TimeoutSec s."
Write-Host "Verifiez qu'aucune autre instance ne tourne (zone de notification) et que le port est libre : netstat -ano | findstr :$Port"
exit 2
