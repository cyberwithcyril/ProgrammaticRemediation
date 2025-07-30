<#
<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-AU-000110 by auditing failures for Sensitive Privilege Use.

.DESCRIPTION
This script configures the Windows 10 system to audit failure events for Sensitive Privilege Use. 
Enabling this setting helps identify failed attempts to use highly sensitive privileges (e.g., debugging, impersonation, or backup/restore operations), 
which may indicate malicious activity or privilege misuse. This supports incident detection and forensic analysis as required by STIG guidance.



.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-30
    Last Modified   : 2025-07-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000110
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-AU-000110).ps1 

#>

# WN10-AU-000110 Remediation Script
# The system must be configured to audit Privilege Use - Sensitive Privilege Use failures

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Configure audit policy for Sensitive Privilege Use failures
auditpol /set /subcategory:"Sensitive Privilege Use" /failure:enable

Write-Host "WN10-AU-000110 remediated - Sensitive Privilege Use failure auditing enabled" -ForegroundColor Green
