<#
.SYNOPSIS
Remediates STIG WN10-UR-000030 by assigning the "Back up files and directories" user right only to the Administrators group.

.DESCRIPTION
This script creates a temporary security template, applies it via secedit, and removes non-compliant groups from the privilege.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000030 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-UR-000030 ).ps1 
    
___
# WN10-UR-000030 Remediation Script
# The Back up files and directories user right must only be assigned to the Administrators group

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
SeBackupPrivilege = *S-1-5-32-544
"@

$tempFile = "$env:TEMP\backup_privilege.inf"
$template | Out-File $tempFile -Encoding Unicode

secedit /configure /db "$env:TEMP\backup.sdb" /cfg "$tempFile" /quiet
Remove-Item $tempFile, "$env:TEMP\backup.sdb" -Force -ErrorAction SilentlyContinue

Write-Host "WN10-UR-000030 remediated - Back up privilege restricted to Administrators only" -ForegroundColor Green
