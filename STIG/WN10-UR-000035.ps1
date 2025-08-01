<#
.SYNOPSIS
Enforces STIG control WN10-UR-000035 by configuring the "Change the system time" user right assignment.

.DESCRIPTION
This PowerShell script ensures compliance with the Department of Defense STIG requirement WN10-UR-000035. 
It modifies the local security policy so that only the following principals have the "Change the system time" user right:
 - Administrators
 - LOCAL SERVICE
 - NT SERVICE\autotimesvc

This restriction reduces the risk of unauthorized time changes, which could be exploited to bypass security mechanisms 
such as log correlation, time-based access controls, or scheduled task execution.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-UR-000035).ps1 

#>
# WN10-UR-000035 Remediation Script
# The Change the system time user right must only be assigned to Administrators, Local Service, and NT SERVICE\autotim

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Create and apply security template
$template = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[Privilege Rights]
SeSystemtimePrivilege = *S-1-5-32-544,*S-1-5-19,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420
"@

$tempFile = "$env:TEMP\systime_privilege.inf"
$template | Out-File $tempFile -Encoding Unicode

secedit /configure /db "$env:TEMP\systime.sdb" /cfg "$tempFile" /quiet
Remove-Item $tempFile, "$env:TEMP\systime.sdb" -Force -ErrorAction SilentlyContinue

Write-Host "WN10-UR-000035 remediated - Change system time right restricted to Administrators, Local Service, and NT SERVICE\autotim" -ForegroundColor Green
