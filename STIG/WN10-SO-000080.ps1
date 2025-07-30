<#
.SYNOPSIS
Remediates STIG WN10-SO-000080 by setting a Windows login legal banner title.

.DESCRIPTION
This script sets the login dialog box title displayed before user authentication,
fulfilling STIG WN10-SO-000080.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000080 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000080).ps1 
    
#>
# WN10-SO-000080 Remediation Script
# Configures the Windows dialog box title for the legal banner

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Set legal banner title
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

# Standard DoD legal banner title
$bannerTitle = "DoD Notice and Consent Banner"

Set-ItemProperty -Path $path -Name "LegalNoticeCaption" -Value $bannerTitle -Type String
Write-Host "WN10-SO-000080 remediated - Legal banner title configured" -ForegroundColor Green
