<#
.SYNOPSIS
Ensures compliance with STIG WN10-CC-000005 by disabling camera access from the Windows 10 lock screen.

.DESCRIPTION
This PowerShell script configures the system to prevent camera access when the device is on the lock screen, as required by the Department of Defense Security Technical Implementation Guide (STIG) for Windows 10 (WN10-CC-000005).

Allowing camera access from the lock screen poses a security risk by enabling potential unauthorized usage. To mitigate this, the script modifies the following registry setting:

- **Path:** HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization
- **Value Name:** NoLockScreenCamera
- **Type:** REG_DWORD
- **Value:** 1 (Disable camera access from lock screen)

Setting this value to `1` ensures compliance by preventing camera access prior to user authentication.
#>

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : STIG WN10-CC-000005 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG WN10-CC-000005 ).ps1 
#>

# STIG WN10-CC-000005 - Disable camera access on lock screen

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$valueName = "NoLockScreenCamera"
$valueData = 1  # 1 disables camera on lock screen

# Create the registry path if it doesn't exist
If (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the policy value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

Write-Output "STIG WN10-CC-000005: Camera access on the lock screen has been disabled."
