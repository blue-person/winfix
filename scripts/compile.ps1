# Variables
$OutputContent = ""
$RootDir = Split-Path (Get-Location) -Parent
$ScriptsDir = Join-Path $RootDir "scripts"
$ModulesDir = Join-Path $RootDir "modules"
$OutputFile = Join-Path $RootDir "releases\winfix.ps1"
$Header = @"
################################################################################################################
###                                                                                                          ###
### WARNING: This file is automatically generated DO NOT modify this file directly as it will be overwritten ###
###                                                                                                          ###
################################################################################################################

# Parameters
param (
    [switch]`$IsModule = `$false,
    [switch]`$Silent = `$false
)

# Functions
"@

# Functions
function Get-FolderContent {
    # Parameters
    param (
        [array]$Items = @(),
        [string]$Message = "Joining all files!"
    )

    # Variables
    $OutputContent = ""

    # Get contents of files in folder
    if ($Items.Count -gt 0) {
        Write-Host $Message -ForegroundColor Cyan
        $Items | ForEach-Object {
            $Path = $_.Fullname
            Write-Host "Getting contents of $Path..."
            $Content = Get-Content $Path
            $FilteredContent = $Content | Where-Object { $_ -notmatch "^Import-Module" -and $_ -notmatch "^#" }
            $OutputContent += ($FilteredContent -join "`n") + "`n"
        }
        Write-Host ""
    }
    return $OutputContent
}

# Initial message
Clear-Host
Write-Host "Started process!" -ForegroundColor Cyan

# Remove previous file
if (Get-Item $OutputFile -ErrorAction SilentlyContinue) {
    Write-Host "Deleting previous file..."
    Remove-Item $OutputFile -Force
}

# Add header
Write-Host "Creating content with header..."
$OutputContent += $Header + "`n"
Write-Host ""

# Get all files in the modules folder
$Modules = Get-ChildItem -Path $ModulesDir -Filter *.psm1 
$OutputContent += Get-FolderContent -Items $Modules -Message "Joining all modules!"

# Get all files in the scripts folder
$Scripts = Get-ChildItem -Path $ScriptsDir -Filter *.ps1 | Where-Object { $_.FullName -ne $PSCommandPath }
$OutputContent += Get-FolderContent -Items $Scripts -Message "Joining all scripts!"

# Get all files in the root folder
$Main = Get-ChildItem -Path $RootDir -Filter *.ps1 
$OutputContent += Get-FolderContent -Items $Main -Message "Joining all main files!"

# Save contents
Write-Host "Started to save content!" -ForegroundColor Cyan
Set-Content -Path $OutputFile -Value $OutputContent
Write-Host "Content has been saved in $OutputFile!" -ForegroundColor Green
Write-Host ""

# End script
Pause
Clear-Host
