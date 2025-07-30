<#
.SYNOPSIS
Disables Autoplay for non-volume devices in compliance with STIG ID WN10-CC-000180.

.DESCRIPTION
This script enforces the security requirement outlined in STIG WN10-CC-000180 by configuring the Windows system 
to disable Autoplay for non-volume devices, such as cameras or media players. Allowing Autoplay on these devices 
could enable the automatic execution of malicious code. Disabling this feature mitigates risks from removable devices 
that do not present as standard storage volumes.

This is accomplished by setting the registry key:
- Path: HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
- Name: NoAutoplayfornonVolume
- Type: REG_DWORD
- Value: 1 (Enabled)
#>
.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-30
    Last Modified   : 2025-07-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000180

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000180).ps1 

#>

# WN10-CC-000180 Remediation Script
# Autoplay must be turned off for non-volume devices

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable Autoplay for non-volume devices
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "NoAutoplayfornonVolume" -Value 1 -Type DWord

Write-Host "WN10-CC-000180 remediated - Autoplay disabled for non-volume devices" -ForegroundColor Green

