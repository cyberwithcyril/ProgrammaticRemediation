<#
.SYNOPSIS
Remediates STIG WN10-CC-000170 by enabling the policy "Allow Microsoft accounts to be optional" 
using LGPO.exe to ensure it's properly recognized by STIG scanners.

.DESCRIPTION
This script uses LGPO.exe to set the "AppUseMicrosoftAccount" value under:
Computer Configuration > Administrative Templates > Windows Components > App Runtime

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000170

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000170).ps1 

#>

___

# WN10-CC-000170 Remediation Script
# Enables Microsoft accounts to be optional for modern style apps

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Set registry value
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "MSAOptional" -Value 1 -Type DWord
Write-Host "WN10-CC-000170 remediated successfully" -ForegroundColor Green
