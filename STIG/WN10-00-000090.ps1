<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-00-000090 by requiring local accounts to have password expiration enabled.

.DESCRIPTION
This script enforces security settings in alignment with the Department of Defense STIG requirement WN10-00-000090.
It checks all local user accounts and sets the 'PasswordNeverExpires' property to $false to ensure passwords are 
configured to expire regularly. This reduces the risk of compromised credentials being reused indefinitely.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000090).ps1 
    
#>

# WN10-00-000090 Remediation Script
# Accounts must be configured to require password expiration

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Set maximum password age to require expiration (default 42 days for STIG compliance)
Write-Host "Setting maximum password age to 42 days..." -ForegroundColor Yellow
net accounts /maxpwage:42

# Ensure password expiration is enabled for all local users
Write-Host "Configuring local users to require password expiration..." -ForegroundColor Yellow
Get-LocalUser | Where-Object {$_.Enabled -eq $true -and $_.Name -ne "Guest"} | ForEach-Object {
    Set-LocalUser -Name $_.Name -PasswordNeverExpires $false
    Write-Host "Password expiration enabled for user: $($_.Name)" -ForegroundColor Green
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "WN10-00-000090 remediated - Password expiration configured" -ForegroundColor Green
} else {
    Write-Error "Failed to configure password expiration"
}
