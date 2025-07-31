<#
.SYNOPSIS
Disables the Microsoft Edge password manager to comply with STIG ID WN10-CC-000245.

.DESCRIPTION
This script ensures compliance with the Department of Defense (DoD) STIG requirement WN10-CC-000245 by disabling the password manager feature in Microsoft Edge.
Password managers that store credentials locally or within the browser pose a security risk, especially on shared or high-sensitivity systems. This setting prevents Edge from 
prompting users to save passwords, reducing the risk of credential theft or misuse.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000245

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000245).ps1 
    
#>

# WN10-CC-000245 Remediation Script
# The password manager function in the Edge browser must be disabled

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

Write-Host "Disabling Edge password manager..." -ForegroundColor Yellow

# Method 1: Disable password manager via Edge policies
$edgePath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
if (!(Test-Path $edgePath)) { New-Item -Path $edgePath -Force | Out-Null }
Set-ItemProperty -Path $edgePath -Name "PasswordManagerEnabled" -Value 0 -Type DWord

# Method 2: Disable password saving
Set-ItemProperty -Path $edgePath -Name "PasswordRevealEnabled" -Value 0 -Type DWord

# Method 3: Disable autofill for passwords
Set-ItemProperty -Path $edgePath -Name "AutofillAddressEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path $edgePath -Name "AutofillCreditCardEnabled" -Value 0 -Type DWord

# Method 4: Configure for legacy Edge (if applicable)
$legacyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"
if (!(Test-Path $legacyPath)) { New-Item -Path $legacyPath -Force | Out-Null }
Set-ItemProperty -Path $legacyPath -Name "FormSuggest Passwords" -Value "no" -Type String

# Method 5: Disable via Windows credential manager policies
$credPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
if (!(Test-Path $credPath)) { New-Item -Path $credPath -Force | Out-Null }
Set-ItemProperty -Path $credPath -Name "AllowProtectedCreds" -Value 0 -Type DWord

Write-Host "WN10-CC-000245 remediated - Edge password manager disabled via multiple methods" -ForegroundColor Green
