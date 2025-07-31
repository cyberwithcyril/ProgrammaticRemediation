<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-SO-000205 by configuring the system to only allow NTLMv2 responses and refuse LM and NTLM authentication.

.DESCRIPTION
This PowerShell script enforces secure authentication by setting the LanMan authentication level to allow only NTLMv2 responses while rejecting LM and NTLM protocols.
This configuration aligns with the DoD STIG requirement WN10-SO-000205 and strengthens the system against downgrade attacks and credential theft by disabling legacy authentication methods.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000205).ps1 

#>

# WN10-SO-000205 Remediation Script
# The LanMan authentication level must be set to send NTLMv2 response only, and to refuse LM and NTLM

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Set LanMan authentication level to NTLMv2 only (value 5)
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
Set-ItemProperty -Path $path -Name "LmCompatibilityLevel" -Value 5 -Type DWord

Write-Host "WN10-SO-000205 remediated - LanMan authentication set to NTLMv2 only" -ForegroundColor Green
