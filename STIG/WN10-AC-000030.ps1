<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-AC-000030 by setting the minimum password age.

.DESCRIPTION
This script configures the system to enforce a minimum password age of at least 1 day.
This prevents users from circumventing password history requirements by repeatedly changing 
their password in a short period of time. It aligns with DoD STIG requirements for secure 
password management.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-30
    Last Modified   : 2025-07-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000030).ps1 
    
#>
# WN10-AC-000030 Remediation Script
# The minimum password age must be configured to at least 1 day

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Set minimum password age to 1 day using net accounts
Write-Host "Setting minimum password age to 1 day..." -ForegroundColor Yellow
net accounts /minpwage:1

if ($LASTEXITCODE -eq 0) {
    Write-Host "WN10-AC-000030 remediated - Minimum password age set to 1 day" -ForegroundColor Green
} else {
    Write-Error "Failed to set minimum password age"
}
