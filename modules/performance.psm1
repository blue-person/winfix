# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Disable-BingSearch {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer"; Name = "DisableSearchBoxSuggestions"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BingSearchEnabled"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "CortanaConsent"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Policies\Microsoft\Windows\Explorer"; Name = "DisableSearchBoxSuggestions"; Type = "REG_DWORD"; Value = "1" }
    )

    # Edit registry keys
    Write-Host "Disabling web results in search!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Disable-AppxProcesses {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"; Name = "GlobalUserDisabled"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BackgroundAppGlobalToggle"; Type = "REG_DWORD"; Value = "0" }
    )

    # Edit registry keys
    Write-Host "Stopping AppX packages from running in the background!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Set-PerformanceDisplay {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Control Panel\Desktop"; Name = "DragFullWindows"; Type = "REG_SZ"; Value = "0" },
        @{Path = "HKCU\Control Panel\Desktop"; Name = "MenuShowDelay"; Type = "REG_SZ"; Value = "100" },
        @{Path = "HKCU\Control Panel\Desktop"; Name = "UserPreferencesMask"; Type = "REG_BINARY"; Value = "9032078010000000" },
        @{Path = "HKCU\Control Panel\Desktop\WindowMetrics"; Name = "MinAnimate"; Type = "REG_SZ"; Value = "0" },
        @{Path = "HKCU\Control Panel\Keyboard"; Name = "KeyboardDelay"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ListviewAlphaSelect"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ListviewShadow"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowTaskViewButton"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarAnimations"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarDa"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarMn"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"; Name = "VisualFXSetting"; Type = "REG_DWORD"; Value = "3" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Name = "EnableTransparency"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\DWM"; Name = "EnableAeroPeek"; Type = "REG_DWORD"; Value = "0" }
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
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}