<#!
.SYNOPSIS
Ensures compliance with STIG ID WN10-00-000175 by disabling the Secondary Logon service.

.DESCRIPTION
This PowerShell script disables the Secondary Logon service (seclogon) on Windows 10 systems to prevent users
from running programs with alternate credentials. Disabling this service reduces the risk of elevation of privilege attacks by preventing users from launching processes under a different user context.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000175).ps1 
    
#>

# WN10-00-000175 Remediation Script
# The Secondary Logon service must be disabled on Windows 10

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

Write-Host "Disabling Secondary Logon service..." -ForegroundColor Yellow

# Stop the service if running
$service = Get-Service -Name "seclogon" -ErrorAction SilentlyContinue
if ($service) {
    if ($service.Status -eq "Running") {
        Write-Host "Stopping Secondary Logon service..." -ForegroundColor Cyan
        Stop-Service -Name "seclogon" -Force
    }
    
    # Disable the service
    Write-Host "Disabling Secondary Logon service..." -ForegroundColor Cyan
    Set-Service -Name "seclogon" -StartupType Disabled
    
    Write-Host "WN10-00-000175 remediated - Secondary Logon service disabled" -ForegroundColor Green
} else {
    Write-Host "Secondary Logon service not found" -ForegroundColor Yellow
}
