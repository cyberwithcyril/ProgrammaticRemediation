<#
.SYNOPSIS
Disables Windows Game Recording and Broadcasting to comply with STIG WN10-CC-000252.

.DESCRIPTION
This script configures the registry to disable GameDVR by setting AllowGameDVR to 0 under the required policy path.
This aligns the system with the Department of Defense STIG requirement WN10-CC-000252.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000252

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000252).ps1 


# WN10-CC-000252 Remediation Script
# Windows 10 must be configured to disable Windows Game Recording and Broadcasting

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable Game DVR and Broadcasting
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "AllowGameDVR" -Value 0 -Type DWord

Write-Host "WN10-CC-000252 remediated - Windows Game Recording and Broadcasting disabled" -ForegroundColor Green

