# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Set-PerformanceDisplay {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Control Panel\Desktop"; Name = "DragFullWindows"; Type = "REG_SZ"; Value = "0"},
        @{Path = "HKCU\Control Panel\Desktop"; Name = "MenuShowDelay"; Type = "REG_SZ"; Value = "100"},
        @{Path = "HKCU\Control Panel\Desktop"; Name = "UserPreferencesMask"; Type = "REG_BINARY"; Value = "9032078010000000"},
        @{Path = "HKCU\Control Panel\Desktop\WindowMetrics"; Name = "MinAnimate"; Type = "REG_SZ"; Value = "0"},
        @{Path = "HKCU\Control Panel\Keyboard"; Name = "KeyboardDelay"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ListviewAlphaSelect"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ListviewShadow"; Type = "REG_DWORD"; Value = "1"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowTaskViewButton"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarAnimations"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarDa"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarMn"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"; Name = "VisualFXSetting"; Type = "REG_DWORD"; Value = "3"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Type = "REG_DWORD"; Value = "1"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Name = "EnableTransparency"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\DWM"; Name = "EnableAeroPeek"; Type = "REG_DWORD"; Value = "0"}
    )

    # Edit registry keys
    Write-Host "Disabling visual effects!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""

    # Edit registry keys as admin
    try {
        Invoke-ElevatedShell "
            # Structures
            `$Keys = @(
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation'; Name = 'DefaultValue'; Type = 'REG_DWORD'; Value = '0'}
            )

            # Edit registry keys
            Write-Host 'Disabling visual effects!' -ForegroundColor Cyan
            foreach (`$Key in `$Keys) {
                Set-RegistryKey -Path `$Key.Path -Name `$Key.Name -Type `$Key.Type -Value `$Key.Value
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Set-PowerPlan {
    # Parameters
    param (
        [Parameter(Mandatory=$true)][string]$Plan,
        $MonitorTimeout = 5,
        $StandbyTimeout = 10
    )

    # Structures
    $PowerPlans = @(
        @{Name = "Low"; Original = "a1841308-3541-4fab-bc81-f71556f20b4a"; Installed = "56deaa71-83cb-4248-8fa6-e936f8abb2bf"},
        @{Name = "Balanced"; Original = "381b4222-f694-41f0-9685-ff5bb260df2e"; Installed = "0ef180f5-2ba4-49cd-808c-299010093150"},
        @{Name = "High"; Original = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"; Installed = "3cd31203-a89f-487f-982c-4595b4d4a4f2"},
        @{Name = "Ultimate"; Original = "e9a42b02-d5df-448d-aa00-03f14749eb61"; Installed = "0549ff6e-575f-4148-a541-29a0a3c15dac"}
    )

    # Variables
    $SelectedPlan = $PowerPlans | Where-Object { $_.Name -eq $Plan }
    $OriginalGUID = $SelectedPlan.Original
    $InstalledGUID = $SelectedPlan.Installed

    # Execute as admin
    try {
        Invoke-ElevatedShell "
            Write-Host 'Started tweaking power plan!' -ForegroundColor Cyan

            # Restore power schemes
            Write-Host 'Installing power schemes...'
            powercfg -restoredefaultschemes #| Out-Null
            powercfg -duplicatescheme $OriginalGUID $InstalledGUID | Out-Null

            # Set high performance
            Write-Host 'Setting $Plan Performance Mode...'
            powercfg -setactive $InstalledGUID

            # Change timeout options
            Write-Host 'Changing power plan Settings...'
            powercfg -hibernate off
            powercfg -change disk-timeout-ac 1
            powercfg -change disk-timeout-dc 0
            powercfg -change monitor-timeout-ac $MonitorTimeout
            powercfg -change monitor-timeout-dc $MonitorTimeout
            powercfg -change standby-timeout-ac $StandbyTimeout
            powercfg -change standby-timeout-dc $StandbyTimeout
            Write-Host ''

            # Wait to continue
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Invoke-DiskRepair {
    # Execute as admin
    try {
        Invoke-ElevatedShell "
            # Repair drive
            Write-Host '(1/4) Started fixing filesystem integrity!' -ForegroundColor Cyan
            chkdsk /scan
            Write-Host ''

            Write-Host '(2/4) Started first SFC scan!' -ForegroundColor Cyan
            sfc /scannow
            Write-Host ''

            Write-Host '(3/4) Started fixing drive with DISM!' -ForegroundColor Cyan
            dism /online /cleanup-image /restorehealth
            Write-Host ''
            
            Write-Host '(4/4) Started second SFC scan!' -ForegroundColor Cyan
            sfc /scannow
            Write-Host ''

            # Wait to continue
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
 }
 