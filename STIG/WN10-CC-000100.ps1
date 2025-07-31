<#
.SYNOPSIS
Prevents downloading print driver packages over HTTP to enhance system security.

.DESCRIPTION
This script enforces STIG compliance with WN10-CC-000100 by configuring Windows to block print driver packages from being downloaded over unsecured HTTP connections. 
Allowing driver downloads over HTTP can expose the system to man-in-the-middle (MITM) attacks and unauthorized driver installations.
The setting is applied through a registry key that disables HTTP-based print driver download functionality.
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
    STIG-ID         : WN10-CC-000100 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000100).ps1 
    
#>

# WN10-CC-000100 Remediation Script
# Downloading print driver packages over HTTP must be prevented

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Prevent downloading print driver packages over HTTP
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "DisableWebPnPDownload" -Value 1 -Type DWord

Write-Host "WN10-CC-000100 remediated - Print driver downloads over HTTP prevented" -ForegroundColor Green
