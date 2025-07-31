<#
.SYNOPSIS
Enables Windows Defender SmartScreen for File Explorer to comply with STIG ID WN10-CC-000210.

.DESCRIPTION
This PowerShell script enforces the configuration of the Windows Defender SmartScreen feature for File Explorer.
SmartScreen helps protect users from malicious files and apps by warning or blocking unrecognized content.
This setting ensures that the feature is turned on, reducing the risk of social engineering or malware attacks
through downloaded files or USB devices.

This setting must be configured to "Enabled" to meet Department of Defense (DoD) security requirements.
.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000210 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000210).ps1 
    
#>

# WN10-CC-000210 Remediation Script
# The Windows Defender SmartScreen for Explorer must be enabled

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

Write-Host "Enabling Windows Defender SmartScreen for Explorer..." -ForegroundColor Yellow

# Method 1: Enable SmartScreen via System policy
$path1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
if (!(Test-Path $path1)) { New-Item -Path $path1 -Force | Out-Null }
Set-ItemProperty -Path $path1 -Name "EnableSmartScreen" -Value 1 -Type DWord

# Method 2: Configure SmartScreen behavior
$path2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
Set-ItemProperty -Path $path2 -Name "ShellSmartScreenLevel" -Value "Block" -Type String

# Method 3: Enable SmartScreen for File Explorer
$path3 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
Set-ItemProperty -Path $path3 -Name "SmartScreenEnabled" -Value "RequireAdmin" -Type String

# Method 4: Configure Windows Defender SmartScreen
$path4 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen"
if (!(Test-Path $path4)) { New-Item -Path $path4 -Force | Out-Null }
Set-ItemProperty -Path $path4 -Name "ConfigureAppInstallControlEnabled" -Value 1 -Type DWord
Set-ItemProperty -Path $path4 -Name "ConfigureAppInstallControl" -Value "Anywhere" -Type String

Write-Host "WN10-CC-000210 remediated - Windows Defender SmartScreen for Explorer enabled" -ForegroundColor Green
