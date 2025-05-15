# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Invoke-SystemRestore {
    try {
        Invoke-ElevatedShell "
            Write-Host 'Started creating system restore point!' -ForegroundColor Cyan

            # Check if System Restore is enabled for the main drive
            Write-Host 'Checking if System Restore is enabled...'
            try {
                # Try getting restore points to check if System Restore is enabled
                Enable-ComputerRestore -Drive '$env:SystemDrive'
            } catch {
                Write-Host 'An error occurred while enabling System Restore: $_'
                Exit-Process
            }

            # Check if the creation frequency value exists
            Write-Host 'Checking if the system allows multiple restore points...'
            `$Frequency = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -ErrorAction SilentlyContinue
            if (`$null -eq `$Frequency) {
                Write-Host 'Changing system to allow multiple restore points per day...'
                Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -Value '0' -Type DWord -Force -ErrorAction Stop | Out-Null
            }

            # Attempt to load the required module for Get-ComputerRestorePoint
            Write-Host 'Loading management modules...'
            try {
                Import-Module Microsoft.PowerShell.Management -ErrorAction Stop
            } catch {
                Write-Host 'Failed to load the Microsoft.PowerShell.Management module: $_'
                Exit-Process
                return
            }

            # Get all the restore points for the current day
            Write-Host 'Getting all the restore points from today...'
            try {
                `$RestorePoints = Get-ComputerRestorePoint | Where-Object { `$_.CreationTime.Date -eq (Get-Date).Date }
            } catch {
                Write-Host 'Failed to retrieve restore points: $_'
                Exit-Process
                return
            }

            # Check if there is already a restore point created today
            Write-Host 'Checking if there is already a restoir point from today...'
            if (`$RestorePoints.Count -eq 0) {
                Write-Host 'Creating a restore point with the current system settings...'
                Checkpoint-Computer -Description 'Restore point created by Winfix' -RestorePointType 'MODIFY_SETTINGS'
                Write-Host 'Restore Point created successfully!' -ForegroundColor Green 
            }
            Write-Host ''
            Exit-Process
      "
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Exit-Process
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
            dism /Online /Cleanup-Image /RestoreHealth
            Write-Host ''
            
            Write-Host '(4/4) Started second SFC scan!' -ForegroundColor Cyan
            sfc /scannow
            Write-Host ''

            # Wait to continue
            Exit-Process
        "
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Exit-Process
    }
}
 
function Invoke-DiskCleanup {
    # Clean Manager
    Write-Host "(1/4) Using Clean Manager to perform cleanup operations!" -ForegroundColor Cyan
    Write-Host "Waiting for process to finish..."
    cleanmgr /d "C:" /verylowdisk
    Write-Host ""
    
    # Delete user temp folder
    Write-Host "(2/4) Deleting files from $env:TEMP!" -ForegroundColor Cyan
    Remove-FolderContent $env:TEMP
    Write-Host ""
    
    # Execute as admin
    try {
        Invoke-ElevatedShell "
            # Delete system temp folder
            Write-Host '(3/4) Deleting files from C:\Windows\Temp!' -ForegroundColor Cyan
            Remove-FolderContent 'C:\Windows\Temp'
            Write-Host ''

            # DISM Cleanup
            Write-Host '(4/4) Using DISM to perform cleanup operations!' -ForegroundColor Cyan
            dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
            Write-Host ''
            Exit-Process
        "
    }
    catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Exit-Process
    }
}
