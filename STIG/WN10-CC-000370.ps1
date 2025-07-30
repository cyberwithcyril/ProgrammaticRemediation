<#
.SYNOPSIS
Disables Windows Hello for Business convenience PIN sign-in per STIG ID WN10-CC-000370.

.DESCRIPTION
This script configures the Group Policy setting that disables the use of a convenience PIN 
for logon on Windows 10 systems, as required by the Department of Defense STIG WN10-CC-000370.
It modifies the appropriate registry key to enforce the policy.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-30
    Last Modified   : 2025-07-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000370).ps1 
#>

# WN10-CC-000370 Remediation Script
# The convenience PIN for Windows 10 must be disabled

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable convenience PIN
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "AllowDomainPINLogon" -Value 0 -Type DWord

Write-Host "WN10-CC-000370 remediated - Convenience PIN disabled" -ForegroundColor Green
