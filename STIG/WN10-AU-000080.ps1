<#
.SYNOPSIS
Ensures auditing of Special Logon successes is enabled to track the use of privileged accounts in compliance with STIG ID WN10-AU-000080.

.DESCRIPTION
This script enforces the STIG requirement WN10-AU-000080 by enabling the audit policy for "Logon/Logoff - Special Logon: Success". 
Special Logon auditing is essential for detecting logon activity by accounts assigned elevated privileges, such as members of the 
Administrators, Domain Admins, or other sensitive groups. These events are critical for tracking privileged access and supporting 
security monitoring, incident response, and forensic investigations. This audit category helps meet security best practices and 
Department of Defense compliance requirements.



.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000080

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000080).ps1 

#>

___

# WN10-AU-000080 Remediation Script
# The system must be configured to audit Logon/Logoff - Special Logon successes

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Configure audit policy for Special Logon successes
auditpol /set /subcategory:"Special Logon" /success:enable

Write-Host "WN10-AU-000080 remediated - Special Logon success auditing enabled" -ForegroundColor Green
