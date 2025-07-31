<#
.SYNOPSIS
Disables Microsoft consumer experiences to comply with STIG ID WN10-CC-000197.

.DESCRIPTION
This script ensures compliance with the Department of Defense (DoD) STIG requirement WN10-CC-000197 by turning off Microsoft consumer experiences. These experiences include unsolicited third-party app installations, tips, advertisements, and suggestions pushed by Microsoft. Disabling this feature reduces potential distractions, unnecessary network communication, and minimizes the attack surface by preventing unapproved software from being installed automatically.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000197).ps1 

#>

# WN10-CC-000197 Remediation Script
# Microsoft consumer experiences must be turned off

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable Microsoft consumer experiences
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord

Write-Host "WN10-CC-000197 remediated - Microsoft consumer experiences disabled" -ForegroundColor Green
