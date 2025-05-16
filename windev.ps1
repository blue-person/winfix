# Import modules
Import-Module ".\modules\customization.psm1" -Force
Import-Module ".\modules\maintenance.psm1" -Force
Import-Module ".\modules\menu.psm1" -Force
Import-Module ".\modules\mods.psm1" -Force
Import-Module ".\modules\performance.psm1" -Force

# Functions
function Show-MainMenu {
    # Variables
    $DisplayMenu = $true
    $WindowTitle = "Winfix Toolbox"
    $MenuTitle = "Windows Fixer Toolbox!" 
    $MenuOptions = @(
        @{Name = "Maintenance Settings"; Description = "Settings for basic maintenance on the device" },
        @{Name = "Customization Settings"; Description = "Some options to customize Windows" },
        @{Name = "Essential Settings"; Description = "Basic tweaks for improved performance" },
        @{Name = "Advanced Settings"; Description = "Advanced tuning, but handle with caution" },
        @{Name = "Exit"; Description = "Close toolbox" }
    )

    # Change window title
    Set-WindowTitle $WindowTitle

    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Show-MaintenanceMenu; break }
            (1) { Show-CustomizationMenu; break }
            (2) { Show-EssentialsMenu; break }
            (3) { Show-AdvancedMenu; break }
            (4) { Set-WindowTitle "PowerShell"; $DisplayMenu = $false; break }
        }
    }
}

function Show-MaintenanceMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Maintenance Options"
    $MenuOptions = @(
        @{Name = "Create Checkpoint"; Description = "Do a system checkpoint in case a revert is needed" },
        @{Name = "Clean Drive"; Description = "Cleanup unnecessary files, but may take some time" },
        @{Name = "Repair Drive"; Description = "Repair the current drive, but may take some time" },
        @{Name = "Return to main menu"; Description = "Close current menu" }
    )
    
    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Invoke-SystemRestore; break }
            (1) { Invoke-DiskCleanup; break }
            (2) { Invoke-DiskRepair; break }
            (3) { $DisplayMenu = $false; break }
        }
    }
}

function Show-CustomizationMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Customization Options"
    $MenuOptions = @(
        @{Name = "Enable Dark Theme"; Description = "Set dark theme...duh!" },
        @{Name = "Change Date Preferences"; Description = "Set time and date format to my personal favorite" },
        @{Name = "Change Explorer Preferences"; Description = "Set File Explorer preferences to my personal favorite" },
        @{Name = "Remove Gallery from Explorer"; Description = "Remove Home and Gallery from File Explorer" },
        @{Name = "Return to main menu"; Description = "Close current menu" }
    )
 
    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Set-DarkTheme; break }
            (1) { Set-DatePreferences; break }
            (2) { Set-ExplorerPreferences; break }
            (3) { Remove-ExplorerGallery; break }
            (4) { $DisplayMenu = $false; break }
        }
    }    
}

function Show-EssentialsMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Essentials Tweaks"
    $MenuOptions = @(
        @{Name = "Set High Power Plan"; Description = "Set the power plan to high performance" },
        @{Name = "Reduce VFX"; Description = "Configure the system appearance for better performance" },
        @{Name = "Disable Bing Search"; Description = "Disable Bing integration in Windows Search" },
        @{Name = "Disable AppX Processes"; Description = "Disable Microsoft Store apps from running in the background" },
        @{Name = "Return to main menu"; Description = "Close current menu" }
    )

    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
           (0) { Set-PowerPlan -Plan "High"; break }
           (1) { Set-PerformanceDisplay; break }
           (2) { Disable-BingSearch; break }
           (3) { Disable-AppxProcesses; break }
           (4) { $DisplayMenu = $false; break }
        }
    }
}

function Show-AdvancedMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Advanced Tweaks"
    $MenuOptions = @(
        @{Name = "Set Ultimate Power Plan"; Description = "Set the power plan to ultimate performance" },
        @{Name = "Disable Telemetry"; Description = "Manage some settings to stop telemetry" },
        @{Name = "Remove Microsoft Apps"; Description = "Remove bloatware such as Skype and Bing News" },
        @{Name = "Disable Non-Essential Processes"; Description = "Disable processes such as GameDVR and Consumer Features" },
        @{Name = "Disable Non-Essential Services"; Description = "Set some services to start on demand rather than on startup" },
        @{Name = "Disable Adobe Services"; Description = "Manage Adobe, Adobe Desktop, and Acrobat Updates services" },
        @{Name = "Enable OS Verbose Mode"; Description = "Allow detailed messages during the login and BSOD process" },
        @{Name = "Prefer IPv4 over IPv6"; Description = "Prefer IPv4 over IPv6 when possible" },
        @{Name = "Return to main menu"; Description = "Close current menu" }
    )
 
    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Set-PowerPlan -Plan "Ultimate"; break }
            (1) { Disable-Telemetry; break }
            (2) { Remove-MicrosoftApps; break }
            (3) { Disable-SystemProcesses; break }
            (4) { Disable-SystemServices; break }
            (5) { Disable-AdobeServices; break }
            (6) { Enable-VerboseMode; break }
            (7) { Set-IPv6Preferences -Setting "PreferIPv4"; break }
            (8) { $DisplayMenu = $false; break }
        }
    }
}

function Invoke-Winfix {
    # Variables
    $Uri = "https://github.com/blue-person/winfix/releases/latest/download/winfix.ps1"
    $File = "$env:TEMP\winfix.ps1"

    # Download and run
    Invoke-WebRequest -Uri $Uri -OutFile $File
    & powershell -ExecutionPolicy Bypass -File $File
}

# Start program
try {
    # Early exit
    if ($Bypass) {
        return
    }

    # Run script based on environment
    if ($PSCommandPath) {
        Show-MainMenu
    }
    else {
        Invoke-Winfix
    }
}
catch {
    Write-Error "Something fatal happend: $_"
}
