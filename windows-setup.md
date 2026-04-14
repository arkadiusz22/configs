# Windows Setup (WSL-Optimized)

## 1. Core System & Power Configuration

### Region & Language

- **Country:** Poland
- **Input Languages:**
  - **Primary:** Polish (Programmers)
  - **Secondary:** English (US QWERTY)
- **Clipboard History:** Enable via `Win + V` to maintain a multi-entry stack.

### Power & Kernel Optimization

```powershell
# Disable hibernation to remove hiberfil.sys and disable Fast Startup
# This ensures a cold boot and prevents NTFS/WSL2 filesystem sync issues
powercfg /hibernate off

# Set display timeout to 5 minutes (AC power)
powercfg /change monitor-timeout-ac 5

# Set disk timeout to 0 (never sleep) to ensure constant I/O availability
powercfg /change disk-timeout-ac 0
```

---

## 2. Browser — Firefox (Primary)

### Installation & Extensions

- **Primary Browser:** Firefox
- **Essential Extensions:**
  - **uBlock Origin:** Content filtering and telemetry blocking.
  - **React Developer Tools:** Component profiling and state debugging.

### Set Firefox as Default

Manual intervention is required due to Windows 11 protocol associations:
`Settings → Apps → Default Apps → Search "Firefox" → Click "Set default"`

### Microsoft Edge Mitigation

Edge is deeply integrated into the Windows 11 shell. Complete removal is often reverted by Windows Update; therefore, a suppression strategy is preferred.

```powershell
# Attempt removal via winget (if supported by the specific build)
winget uninstall --id Microsoft.Edge --force

# Alternative: Execute the Edge setup binary directly for force-uninstallation
$edgeSetupPath = "C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe"
$setup = Get-Item $edgeSetupPath | Select-Object -Last 1
if ($setup) {
    Start-Process -FilePath $setup.FullName -ArgumentList "--uninstall", "--system-level", "--verbose-logging", "--force-uninstall" -Wait
}
```

---

## 3. Core Software Stack

| Component     | Role              | Technical Notes                                                              |
| :------------ | :---------------- | :--------------------------------------------------------------------------- |
| **Firefox**   | Primary Browser   | Optimized for privacy; primary tool for web debugging.                       |
| **WSL 2**     | Linux Environment | Native Linux kernel via Hyper-V; install Ubuntu 24.04 LTS.                   |
| **VS Code**   | Primary IDE       | Connect via `ms-vscode-remote.remote-wsl` for a native Linux dev experience. |
| **Fira Code** | Monospaced Font   | Supports programming ligatures (e.g., `=>`, `!==`). Install on Windows host. |

---

## 4. Automated System Tweaks (Admin PowerShell)

### 4.1. Explorer & UI Visibility

```powershell
$Exp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Show file extensions, hidden files, and protected OS files (ShowSuperHidden)
Set-ItemProperty -Path $Exp -Name "HideFileExt" -Value 0
Set-ItemProperty -Path $Exp -Name "Hidden" -Value 1
Set-ItemProperty -Path $Exp -Name "ShowSuperHidden" -Value 0

# Navigation and Behavior
Set-ItemProperty -Path $Exp -Name "NavPane_ShowOneDriveByDefault" -Value 0  # Hide OneDrive sidebar
Set-ItemProperty -Path $Exp -Name "ShowSyncProviderNotifications" -Value 0 # Disable Explorer ads
```

### 4.2. Telemetry & Privacy

```powershell
# Core Telemetry (System Level)
$DataColl = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (!(Test-Path $DataColl)) { New-Item -Path $DataColl -Force }
Set-ItemProperty -Path $DataColl -Name "AllowTelemetry" -Value 0

# Activity History & Advertising
$WinSys = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
if (!(Test-Path $WinSys)) { New-Item -Path $WinSys -Force }
Set-ItemProperty -Path $WinSys -Name "EnableActivityFeed" -Value 0
Set-ItemProperty -Path $WinSys -Name "PublishUserActivities" -Value 0

$Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
Set-ItemProperty -Path $Adv -Name "Enabled" -Value 0

# Content Delivery Manager (Start Menu Ads, Suggestions, Lockscreen)
$CDM = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
$CDMTweaks = @{
    "SystemPaneSuggestionsEnabled" = 0
    "SoftLandingEnabled"           = 0
    "RotatingLockScreenEnabled"    = 0
    "SubscribedContent-338388Enabled" = 0 # Experience ads
    "SubscribedContent-338393Enabled" = 0 # Tips/Notifications
    "SubscribedContent-353696Enabled" = 0 # Settings suggestions
}
foreach ($Name in $CDMTweaks.Keys) {
    Set-ItemProperty -Path $CDM -Name $Name -Value $CDMTweaks[$Name]
}
```

### 4.3. Performance & Update Management

```powershell
# Set visual effects to 'Best Performance' (Disables animations)
$Visual = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
Set-ItemProperty -Path $Visual -Name "VisualFXSetting" -Value 2

# Windows Update Active Hours (6:00 - 22:00)
$WU = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
if (!(Test-Path $WU)) { New-Item -Path $WU -Force }
Set-ItemProperty -Path $WU -Name "ActiveHoursStart" -Value 6
Set-ItemProperty -Path $WU -Name "ActiveHoursEnd" -Value 22

# Stop and disable unnecessary management services (Intel AMT)
Stop-Service AIMTManageabilityService -ErrorAction SilentlyContinue
Set-Service AIMTManageabilityService -StartupType Disabled -ErrorAction SilentlyContinue

# Remove OneDrive from Startup
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" -ErrorAction SilentlyContinue
```

> [!NOTE]
> **Manual Steps Checklist:**
>
> - Startup Apps: `Ctrl + Shift + Esc` -> Disable high-impact non-essentials.
> - Notifications: `Settings → System → Notifications` -> Disable "Offer suggestions" at the bottom.
> - Update Notifications: `Settings → Windows Update → Advanced options` -> Enable "Notify me when a restart is required".

---

## 5. Typography & Terminal Integration

### 5.1. Fira Code Installation

1. Download from [Fira Code GitHub](https://github.com/tonsky/FiraCode/wiki/Installing#windows).
2. Install all `.ttf` files to the Windows host.

### 5.2. Windows Terminal Profile (WSL Focus)

**JSON Fragment (`settings.json`):**

```json
{
  "defaultProfile": "{ubuntu-24-04-guid}",
  "profiles": {
    "list": [
      {
        "guid": "{ubuntu-24-04-guid}",
        "name": "Ubuntu 24.04",
        "commandline": "wsl.exe -d Ubuntu-24.04 --cd ~",
        "font": {
          "face": "Fira Code",
          "size": 12,
          "features": { "calt": 1 }
        },
        "startingDirectory": "//wsl$/Ubuntu-24.04/home/arekz"
      }
    ]
  }
}
```

---

## 6. App Inventory & Environment

### List Installed Applications (PowerShell)

```powershell
# List Win32 (Standard) apps
Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" |
  Select-Object DisplayName, Publisher, DisplayVersion |
  Where-Object { $_.DisplayName -ne $null } |
  Sort-Object DisplayName |
  Format-Table -AutoSize
```

### Windows PATH (User Environment)

| Path Entry                                      | Purpose                          |
| :---------------------------------------------- | :------------------------------- |
| `%LOCALAPPDATA%\Microsoft\WindowsApps`          | Modern Windows execution aliases |
| `%LOCALAPPDATA%\Programs\Microsoft VS Code\bin` | Enables `code .` execution       |
| `C:\Program Files\Git\cmd`                      | Global Git access                |
