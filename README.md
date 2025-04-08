<div align="center">

# Windows Fixer Toolbox 🔧

[![Project Status: WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-green.svg)](LICENSE)

</div>

## Description
This toolbox is a mix of Windows tasks I like to run on every system I use. It’s made to handle fixes and tweaks for debloating, optimizing, and customizing Windows, all packed into a single file. No need to dig through settings and click endlessly. Just run the script, pull up the menu, and set up your system the way you want.

## Usage
Winfix can be used by both non-admin and admin users. If you choose a setting that requires system-wide configurations, the tool will ask for admin permissions. However, your computer must allow PowerShell scripts to run. You can enable this by executing the following command in an admin PowerShell session:

```ps1
Set-ExecutionPolicy Bypass
```

### Launch Command

```ps1
irm "https://github.com/blue-person/winfix/releases/latest/download/winfix.ps1" | iex
```

