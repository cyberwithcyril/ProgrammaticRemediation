<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-CC-000038 by disabling WDigest authentication.

.DESCRIPTION
This script disables WDigest authentication by setting the registry key `UseLogonCredential` to `0`.
WDigest authentication stores user credentials in memory in plain text, which poses a significant security risk.
Disabling this feature helps prevent credential theft via tools such as Mimikatz.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000038).ps1 
    
#>
# WN10-CC-000038 Remediation Script
# WDigest Authentication must be disabled

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable WDigest Authentication
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "UseLogonCredential" -Value 0 -Type DWord

Write-Host "WN10-CC-000038 remediated - WDigest Authentication disabled" -ForegroundColor Green
