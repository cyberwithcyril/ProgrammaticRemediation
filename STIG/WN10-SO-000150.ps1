<#
.SYNOPSIS
Restricts anonymous enumeration of shares to comply with STIG WN10-SO-000150.

.DESCRIPTION
This script ensures the RestrictNullSessShares registry entry exists and is empty, which blocks anonymous users from enumerating shared folders.
This hardens the system in line with Department of Defense STIG security guidance.
.NOTES


    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000150).ps1 



# WN10-SO-000150 Remediation Script
# Anonymous enumeration of shares must be restricted

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Restrict anonymous enumeration of shares
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
Set-ItemProperty -Path $path -Name "RestrictAnonymous" -Value 1 -Type DWord

Write-Host "WN10-SO-000150 remediated - Anonymous enumeration of shares restricted" -ForegroundColor Green
