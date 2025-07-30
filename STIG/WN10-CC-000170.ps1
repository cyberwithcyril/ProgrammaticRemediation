<#
.SYNOPSIS
Remediates STIG WN10-CC-000170 by enabling the policy "Allow Microsoft accounts to be optional" 
using LGPO.exe to ensure it's properly recognized by STIG scanners.

.DESCRIPTION
This script uses LGPO.exe to set the "AppUseMicrosoftAccount" value under:
Computer Configuration > Administrative Templates > Windows Components > App Runtime

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000170

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000170).ps1 

#>

___

# WN10-CC-000170 Remediation Script
# Enables the setting to allow Microsoft accounts to be optional for modern style apps
# 
# STIG Requirement: The setting to allow Microsoft accounts to be optional for modern style apps must be enabled.
# Registry Path: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
# Registry Value: MSAOptional
# Required Setting: 1 (Enabled)

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator. Please run PowerShell as Administrator and try again."
    exit 1
}

Write-Host "Starting WN10-CC-000170 Remediation..." -ForegroundColor Green
Write-Host "Configuring Microsoft accounts to be optional for modern style apps..." -ForegroundColor Yellow

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$registryName = "MSAOptional"
$registryValue = 1

try {
    # Check if the registry path exists, create if it doesn't
    if (!(Test-Path $registryPath)) {
        Write-Host "Creating registry path: $registryPath" -ForegroundColor Yellow
        New-Item -Path $registryPath -Force | Out-Null
    }

    # Get current value if it exists
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue

    if ($currentValue) {
        Write-Host "Current value of $registryName : $($currentValue.$registryName)" -ForegroundColor Cyan
    } else {
        Write-Host "Registry value $registryName does not exist. Creating..." -ForegroundColor Yellow
    }

    # Set the registry value
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -Type DWord
    Write-Host "Successfully set $registryName to $registryValue" -ForegroundColor Green

    # Verify the setting
    $verifyValue = Get-ItemProperty -Path $registryPath -Name $registryName
    if ($verifyValue.$registryName -eq $registryValue) {
        Write-Host "Verification successful: $registryName = $($verifyValue.$registryName)" -ForegroundColor Green
        Write-Host ""
        Write-Host "WN10-CC-000170 Remediation completed successfully!" -ForegroundColor Green
        Write-Host "Microsoft accounts are now optional for modern style apps." -ForegroundColor Green
    } else {
        Write-Error "Verification failed: Expected $registryValue but got $($verifyValue.$registryName)"
        exit 1
    }

} catch {
    Write-Error "An error occurred during remediation: $($_.Exception.Message)"
    exit 1
}

Write-Host ""
Write-Host "Note: A system restart may be required for changes to take full effect." -ForegroundColor Yellow
Write-Host "Script execution completed." -ForegroundColor Green
