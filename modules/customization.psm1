# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Set-DarkTheme {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Name = "AppsUseLightTheme"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Name = "ColorPrevalence"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Name = "SystemUsesLightTheme"; Type = "REG_DWORD"; Value = "0" }
    )

    # Edit registry keys
    Write-Host "Setting dark theme!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Set-DatePreferences {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Control Panel\International"; Name = "iDigits"; Type = "REG_SZ"; Value = "2" },
        @{Path = "HKCU\Control Panel\International"; Name = "iFirstDayOfWeek"; Type = "REG_SZ"; Value = "0" },
        @{Path = "HKCU\Control Panel\International"; Name = "iFirstWeekOfYear"; Type = "REG_SZ"; Value = "0" },
        @{Path = "HKCU\Control Panel\International"; Name = "s1159"; Type = "REG_SZ"; Value = "a.m." },
        @{Path = "HKCU\Control Panel\International"; Name = "s2359"; Type = "REG_SZ"; Value = "p.m." },
        @{Path = "HKCU\Control Panel\International"; Name = "sCurrency"; Type = "REG_SZ"; Value = "$" },
        @{Path = "HKCU\Control Panel\International"; Name = "sDate"; Type = "REG_SZ"; Value = "/" },
        @{Path = "HKCU\Control Panel\International"; Name = "sDecimal"; Type = "REG_SZ"; Value = "." },
        @{Path = "HKCU\Control Panel\International"; Name = "sLongDate"; Type = "REG_SZ"; Value = "dddd, dd 'de' MMMM 'de' yyyy" },
        @{Path = "HKCU\Control Panel\International"; Name = "sMonDecimalSep"; Type = "REG_SZ"; Value = "." },
        @{Path = "HKCU\Control Panel\International"; Name = "sMonThousandSep"; Type = "REG_SZ"; Value = "," },
        @{Path = "HKCU\Control Panel\International"; Name = "sShortDate"; Type = "REG_SZ"; Value = "dd/MM/yyyy" },
        @{Path = "HKCU\Control Panel\International"; Name = "sShortTime"; Type = "REG_SZ"; Value = "hh:mm tt" },
        @{Path = "HKCU\Control Panel\International"; Name = "sThousand"; Type = "REG_SZ"; Value = "," },
        @{Path = "HKCU\Control Panel\International"; Name = "sTime"; Type = "REG_SZ"; Value = ":" },
        @{Path = "HKCU\Control Panel\International"; Name = "sTimeFormat"; Type = "REG_SZ"; Value = "hh:mm:ss tt" }
    )

    # Edit registry keys
    Write-Host "Setting date format to my personal preferences!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Set-ExplorerPreferences {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "Hidden"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "HideFileExt"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "LaunchTo"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowTaskViewButton"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarAl"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarDa"; Type = "REG_DWORD"; Value = "0" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"; Name = "TaskbarEndTask"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager"; Name = "EnthusiastMode"; Type = "REG_DWORD"; Value = "1" },
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Type = "REG_DWORD"; Value = "1" }
    )

    # Edit registry keys
    Write-Host "Setting file explorer to my personal preferences!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Remove-HomeSettings {      
    try {
        # Disable Home page from Windows Settings
        Invoke-ElevatedShell "
            Write-Host 'Removing Home from Windows Settings!' -ForegroundColor Cyan
            Set-RegistryKey -Path 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'SettingsPageVisibility' -Type 'REG_SZ' -Value 'hide:home'
            Write-Host ''
            Pause
        "
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Remove-HomeExplorer {
    # Variables
    $HomeGUID = "{f874310e-b6b7-47dc-bc84-b9e6b38f5903}"
    $GalleryGUID = "{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}"

    # Change current user default launch
    Write-Host "Preparing Explorer!" -ForegroundColor Cyan
    Set-RegistryKey -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type "REG_DWORD" -Value "1"

    try {
        # Delete Home and Gallery
        Invoke-ElevatedShell "
            Write-Host 'Removing Home and Gallery from File Explorer!' -ForegroundColor Cyan
            Remove-RegistryKey -Key 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\$HomeGUID'
            Remove-RegistryKey -Key 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\$GalleryGUID'
            Write-Host ''
            Pause
        "
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}
