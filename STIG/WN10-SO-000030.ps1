<#
.SYNOPSIS
Ensures audit policies are configured using subcategories to provide granular control over security event logging.

.DESCRIPTION
This script ensures that Windows is configured to use audit policy subcategories rather than legacy top-level categories. 
Subcategories allow for precise auditing of security-relevant events such as logon attempts, privilege use, and object access.
This setting enhances visibility and supports compliance and forensic readiness by enabling detailed audit logging.



.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000030).ps1 

#>

___
# WN10-SO-000030 Remediation Script
# Audit policy using subcategories must be enabled

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Enable audit policy subcategories
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
Set-ItemProperty -Path $path -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord

Write-Host "WN10-SO-000030 remediated - Audit policy using subcategories enabled" -ForegroundColor Green
