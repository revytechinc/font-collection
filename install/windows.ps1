# REVYTECH font collection — Windows installer.
# Copies TTF/OTF to the per-user font directory and registers them in HKCU.
# WOFF2 is not required for Windows Fonts.
#
# Default (no admin):
#   $env:LOCALAPPDATA\Microsoft\Windows\Fonts
#   HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts
#
# Admin (optional, documented — not the default):
#   copy the same TTF/OTF into C:\Windows\Fonts, or use the Shell.Application
#   "Fonts" namespace. This script does not require elevation.
#
# Optional package managers (not required):
#   scoop / choco — only if you wrap this tree yourself; this script is enough.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File install\windows.ps1
#   powershell -ExecutionPolicy Bypass -File install\windows.ps1 -Action uninstall

[CmdletBinding()]
param(
    [ValidateSet('install', 'uninstall')]
    [string]$Action = 'install'
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
if (-not $Root) {
    $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
}

$UserFontDir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
$RegPath = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
$Stamp = Join-Path $UserFontDir '.revytech-font-collection.list'

function Get-FaceFiles {
    Get-ChildItem -Path (Join-Path $Root 'fonts') -Recurse -File -Include '*.ttf', '*.otf'
}

function Install-Fonts {
    New-Item -ItemType Directory -Force -Path $UserFontDir | Out-Null
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }
    $names = @()
    foreach ($f in Get-FaceFiles) {
        $dest = Join-Path $UserFontDir $f.Name
        Copy-Item -LiteralPath $f.FullName -Destination $dest -Force
        $display = $f.BaseName + ' (TrueType)'
        New-ItemProperty -Path $RegPath -Name $display -Value $dest -PropertyType String -Force | Out-Null
        $names += $f.Name
        Write-Host "installed $($f.Name)"
    }
    $names | Set-Content -LiteralPath $Stamp -Encoding UTF8
    Write-Host "Installed TTF/OTF to $UserFontDir"
    Write-Host "Admin alternative: copy the same files to C:\Windows\Fonts"
    Write-Host "Log off / restart apps to pick up new faces."
}

function Uninstall-Fonts {
    if (-not (Test-Path -LiteralPath $Stamp)) {
        Write-Error "No stamp file $Stamp; nothing to uninstall."
    }
    $names = Get-Content -LiteralPath $Stamp
    foreach ($name in $names) {
        if (-not $name) { continue }
        $dest = Join-Path $UserFontDir $name
        Remove-Item -LiteralPath $dest -ErrorAction SilentlyContinue
        $base = [System.IO.Path]::GetFileNameWithoutExtension($name)
        Remove-ItemProperty -Path $RegPath -Name ($base + ' (TrueType)') -ErrorAction SilentlyContinue
        Write-Host "removed $name"
    }
    Remove-Item -LiteralPath $Stamp -ErrorAction SilentlyContinue
    Write-Host "Uninstalled."
}

switch ($Action) {
    'install' { Install-Fonts }
    'uninstall' { Uninstall-Fonts }
}
