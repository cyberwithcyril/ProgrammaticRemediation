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

# Enable Windows Defender SmartScreen for Explorer
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "EnableSmartScreen" -Value 1 -Type DWord

Write-Host "WN10-CC-000210 remediated - Windows Defender SmartScreen for Explorer enabled" -ForegroundColor Green
