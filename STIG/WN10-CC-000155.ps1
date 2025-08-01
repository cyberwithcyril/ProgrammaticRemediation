<#!
.SYNOPSIS
Disables Solicited Remote Assistance in accordance with STIG ID WN10-CC-000155.

.DESCRIPTION
This PowerShell script ensures compliance with the Department of Defense STIG requirement WN10-CC-000155.
It configures the system to prevent Solicited Remote Assistance by setting the appropriate Group Policy registry key value.
This setting enhances security by preventing users or support personnel from initiating unsolicited remote control sessions.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000155

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000155).ps1 
    
#>

#Requires -RunAsAdministrator

# WN10-CC-000155: Disable Solicited Remote Assistance
Write-Host "Remediating WN10-CC-000155 - Disabling Remote Assistance..." -ForegroundColor Yellow

try {
    # Primary registry setting
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"
    if (!(Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
    
    Set-ItemProperty -Path $regPath -Name "fAllowToGetHelp" -Value 0 -Type DWord
    Set-ItemProperty -Path $regPath -Name "fAllowUnsolicitedFullControl" -Value 0 -Type DWord
    
    # Group Policy equivalent
    $gpoPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
    if (!(Test-Path $gpoPath)) { New-Item -Path $gpoPath -Force | Out-Null }
    
    Set-ItemProperty -Path $gpoPath -Name "fAllowToGetHelp" -Value 0 -Type DWord
    
    Write-Host "SUCCESS: Remote Assistance disabled - WN10-CC-000155 COMPLIANT" -ForegroundColor Green
    Write-Host "Reboot recommended." -ForegroundColor Cyan
    
} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
