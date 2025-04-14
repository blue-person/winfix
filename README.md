<div align="center">

# Windows Fixer Toolbox 🔧

[![Project Status: WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-green.svg)](LICENSE)

</div>

## Description
This toolbox is a mix of Windows tasks I like to run on every system I use. It’s made to handle fixes and tweaks for debloating, optimizing, and customizing Windows, all packed into a single file. 

Now there's no need to dig through settings and click endlessly. Just run the script, pull up the menu, and set up your system the way you want.

## Usage
Winfix is accessible to both standard and administrative users. If a selected setting requires system-wide changes, the tool will prompt you to grant administrative permissions.

To use this tool, simply launch PowerShell and choose one of the following methods:

#### Recommended method ⚡

```ps1
& powershell -ExecutionPolicy Bypass -File $($File = "$env:TEMP\winfix.ps1"; iwr -Uri "https://github.com/blue-person/winfix/releases/latest/download/winfix.ps1" -OutFile $File; $File)
```

#### Offline method 🖥️

To execute the script locally, your computer must allow PowerShell scripts to run. You can enable this by executing the following command in an admin PowerShell session:

```ps1
Set-ExecutionPolicy Bypass
```

Once this setting is applied, you can download the script and run the following command in either a standard or admin PowerShell session:

```ps1
.\winfix.ps1
```
