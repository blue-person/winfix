function Set-WindowTitle {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Title
    )

    # Change window title
    $Host.UI.RawUI.WindowTitle = $Title
}

function Read-KeyPressed {
    return ([Console]::ReadKey($false)).Key
}

function Show-ErrorMessage {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Title,
        [string]$Message
    )

    # Write error message
    Write-Host $Title -ForegroundColor Red
    if ($Message) {
        Write-Host "Exception Message: $Message" -ForegroundColor Red
        Write-Host ""
    }
}

function Invoke-ElevatedShell {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Script
    )

    # Variables
    $CurrentRole = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    $IsAdmin = $CurrentRole.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    # Execute as admin
    if ($IsAdmin) {
        # We are already an admin, so run as it is
        Invoke-Expression $Script
    }
    else {
        # Start a elevated powershell and run the script
        Start-Process powershell -Wait -ArgumentList @(
            "-NoProfile",
            "-NoLogo",
            "-ExecutionPolicy Bypass",
            "-Command",
            "Import-Module $PSCommandPath -ArgumentList `$true -Force; $Script"
        ) -Verb RunAs
    }
}

function Set-RegistryKey {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Type,
        [Parameter(Mandatory = $true)][string]$Value
    )

    # Set key
    try {
        Write-Host "Setting $Path\$Name to $Value..."
        reg add $Path /v $Name /t $Type /d $Value /f *>$null
    }
    catch {
        Show-ErrorMessage -Title "Unable to set $Path\$Name to $Value!"
    }
}

function Remove-RegistryKey {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Key
    )

    # Set key
    try {
        Write-Host "Deleting $Key..."
        reg delete $Key /f *>$null
    }
    catch {
        Show-ErrorMessage -Title "Unable to remove $Key!"
    }
}

function Remove-FolderContent {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Path
    )

    # Remove all files from path
    Get-ChildItem -Path $Path *.* -Recurse | Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
            Write-Host "Deleted $($_.FullName)..."
        }
        catch {
            $null
        }
    }
    Write-Host "All deletable files were successfully removed!" -ForegroundColor Green
}

function Remove-App {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Name,
        [string]$Type = "App"
    )

    # Remove the app
    try {
        if ($Type -eq "App") {
            Write-Host "Removing $Name..."
            dism /Online /Disable-Feature /FeatureName:$Name /Quiet /NoRestart
        }
        elseif ($Type -eq "Package") {
            Write-Host "Removing everything that looks like $Name..."
            Get-AppxPackage -AllUsers | Where-Object { $_.Name -Like "*$Name*" } | Remove-AppxPackage -AllUsers -ErrorAction Continue
        }
    }
    catch {
        Show-ErrorMessage -Title "Unable to remove $Name!"
    }
}

function Set-ServiceStartup {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Type
    )

    # Set type of startup
    try {
        Write-Host "Setting service $Name to $Type..."
        $Service = Get-Service -Name $Name -ErrorAction Stop
        $Service | Set-Service -StartupType $Type -ErrorAction Stop
    }
    catch {
        Show-ErrorMessage -Title "Unable to set $Name to $Type startup!"
    }
}

function Set-TaskState {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][bool]$State
    )

    # Set availability
    try {
        $Task = $Path + "\$Name"
        if ($State) {
            Write-Host "Enabling scheduled task $Name"
            Enable-ScheduledTask -TaskName $Task -ErrorAction Stop | Out-Null
        }
        else {
            Write-Host "Disabling scheduled task $Name"
            Disable-ScheduledTask -TaskName $Task -ErrorAction Stop | Out-Null
        }
    }
    catch {
        Show-ErrorMessage -Title "Unable to configure $Task!"
    }
}
