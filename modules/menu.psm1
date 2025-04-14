# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Show-Menu {
    # Parameters
    param (
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][array]$Options
    )

    # Variables
    $MaxValue = $Options.count - 1
    $CurrentIndex = 0
    $EnterPressed = $false
    
    # Clear screen
    Clear-Host

    # Keep showing menu
    while (-Not $EnterPressed) {
        # Show title
        Write-Host "$Title"
        Write-Host ""

        # Highlight option
        for ($i = 0; $i -le $MaxValue; $i++) {
            if ($i -eq $CurrentIndex) {
                Write-Host -BackgroundColor Cyan -ForegroundColor Black "[ $($Options[$i].Name) ]"
            }
            else {
                Write-Host "  $($Options[$i].Name)  "
            }
        }

        # Show description
        Write-Host ""
        Write-Host "> $($Options[$CurrentIndex].Description)"

        # Read keyboard
        switch (Read-KeyPressed) {
            ([ConsoleKey]::Enter) {
                Clear-Host
                $EnterPressed = $true
                return $CurrentIndex
                break
            }

            ([ConsoleKey]::UpArrow) {
                Clear-Host
                if ($CurrentIndex -eq 0) {
                    $CurrentIndex = $MaxValue
                }
                else {
                    $CurrentIndex -= 1
                }
                break
            }

            ([ConsoleKey]::DownArrow) {
                Clear-Host
                if ($CurrentIndex -eq $MaxValue) {
                    $CurrentIndex = 0
                }
                else {
                    $CurrentIndex += 1
                }
                break
            }
            Default {
                Clear-Host
            }
        }
    }
}
