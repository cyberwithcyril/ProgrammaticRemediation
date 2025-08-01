<#
.SYNOPSIS
Prevents the Web publishing and online ordering wizards from downloading a list of providers.

.DESCRIPTION
This script enforces compliance with STIG ID WN10-CC-000105 by configuring the Windows registry to block the Web publishing and online ordering wizards from downloading a list of 
providers from the internet. This reduces the system’s exposure to untrusted external content and mitigates the risk of malware distribution or data leakage through unauthorized third-party services.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000105

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000105).ps1 

#>
# WN10-CC-000105 Remediation Script
# Web publishing and online ordering wizards must be prevented from downloading a list of providers

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Prevent web publishing and online ordering wizards from downloading provider lists
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "NoWebServices" -Value 1 -Type DWord

Write-Host "WN10-CC-000105 remediated - Web publishing and online ordering wizard provider downloads prevented" -ForegroundColor Green
