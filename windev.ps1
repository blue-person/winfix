# Import modules
Import-Module ".\modules\customization.psm1" -Force
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
        @{Name = "Essential Tweaks"; Description = "Basic tweaks for improved performance"},
        @{Name = "Advanced Tweaks"; Description = "Advanced tuning, but handle with caution"},
        @{Name = "Customization Options"; Description = "Some options to customize Windows"},
        @{Name = "Exit"; Description = "Close toolbox"}
    )

    # Change window title
    Set-WindowTitle $WindowTitle

    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Show-EssentialsMenu; break }
            (1) { Show-AdvancedMenu; break }
            (2) { Show-CustomizationMenu; break }
            (3) { Set-WindowTitle "PowerShell"; $DisplayMenu = $false; break }
        }
    }
}

function Show-EssentialsMenu {
   # Variables
   $DisplayMenu = $true
   $MenuTitle = "Essentials Tweaks"
   $MenuOptions = @(
        @{Name = "Set High Power Plan"; Description = "Set the power plan to high performance"},
        @{Name = "Disable Bing Search"; Description = "Disable Bing integration in Windows Search"},
        @{Name = "Reduce VFX"; Description = "Configure the system appearance for better performance"},
        @{Name = "Clean Drive"; Description = "Cleanup unnecessary files, but may take some time"},
        @{Name = "Repair Drive"; Description = "Repair the current drive, but may take some time"},
        @{Name = "Return to main menu"; Description = "Close current menu"}
    )

   # Loop to keep the menu active
   while ($DisplayMenu) {
       $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
       switch ($UserSelection) {
           (0) { Set-PowerPlan -Plan "High"; break }
           (1) { Disable-BingSearch; break }
           (2) { Set-PerformanceDisplay; break }
           (3) { Invoke-DiskCleanup; break }
           (4) { Invoke-DiskRepair; break }
           (5) { $DisplayMenu = $false; break }
       }
   }
}

function Show-AdvancedMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Advanced Tweaks"
    $MenuOptions = @(
        @{Name = "Set Ultimate Power Plan"; Description = "Set the power plan to ultimate performance"},
        @{Name = "Disable Telemetry"; Description = "Manage some settings to stop telemetry"},
        @{Name = "Remove Microsoft Apps"; Description = "Remove bloatware such as Skype and Bing News"},
        @{Name = "Disable AppX Processes"; Description = "Disable Microsoft Store apps from running in the background"},
        @{Name = "Disable Non-Essential Processes"; Description = "Disable processes such as GameDVR and Consumer Features"},
        @{Name = "Disable Non-Essential Services"; Description = "Set some services to start on demand rather than on startup"},
        @{Name = "Disable Adobe Services"; Description = "Manage Adobe, Adobe Desktop, and Acrobat Updates services"},
        @{Name = "Enable OS Verbose Mode"; Description = "Allow detailed messages during the login and BSOD process"},
        @{Name = "Prefer IPv4 over IPv6"; Description = "Prefer IPv4 over IPv6 when possible"},
        @{Name = "Return to main menu"; Description = "Close current menu"}
    )
 
    # Loop to keep the menu active
    while ($DisplayMenu) {
        $UserSelection = Show-Menu -Title $MenuTitle -Options $MenuOptions
        switch ($UserSelection) {
            (0) { Set-PowerPlan -Plan "Ultimate"; break }
            (1) { Disable-Telemetry; break }
            (2) { Remove-MicrosoftApps; break }
            (3) { Disable-AppxProcesses; break }
            (4) { Disable-SystemProcesses; break }
            (5) { Disable-SystemServices; break }
            (6) { Disable-AdobeServices; break }
            (7) { Enable-VerboseMode; break }
            (8) { Set-IPv6Preferences -Setting "PreferIPv4"; break }
            (9) { $DisplayMenu = $false; break }
        }
    }
}

function Show-CustomizationMenu {
    # Variables
    $DisplayMenu = $true
    $MenuTitle = "Customization Options"
    $MenuOptions = @(
        @{Name = "Enable Dark Theme"; Description = "Set dark theme...duh!"},
        @{Name = "Change Date Preferences"; Description = "Set time and date format to my personal favorite"},
        @{Name = "Change Explorer Preferences"; Description = "Set File Explorer preferences to my personal favorite"},
        @{Name = "Remove Gallery from Explorer"; Description = "Remove Home and Gallery from File Explorer"},
        @{Name = "Return to main menu"; Description = "Close current menu"}
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

# Show main menu
try {
    if (-not ($Silent -or $IsModule)) {
        Show-MainMenu
    }
} catch {
    $null
}
