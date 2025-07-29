<#
.SYNOPSIS
Ensures compliance with STIG WN10-SO-000255 by configuring User Account Control to automatically deny elevation requests from standard users.

.DESCRIPTION
This PowerShell script sets the required registry key to enforce User Account Control (UAC) to automatically deny elevation requests for standard users.
This ensures that standard users cannot bypass UAC or attempt privilege escalation, in accordance with the Department of Defense STIG requirement WN10-SO-000255.

The script modifies the following registry setting:
Path: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
Value Name: ConsentPromptBehaviorUser
Type: REG_DWORD
Value: 0 (Automatically deny elevation requests)


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000255).ps1 
#>

# User Account Control must automatically deny elevation requests for standard users

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "ConsentPromptBehaviorUser"
$desiredValue = 0

try {
    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Output "Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the registry value
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "✅ Set $valueName to $desiredValue"

    # Force Group Policy update
    Write-Output "Running gpupdate /force..."
    gpupdate /force | Out-Null
    Start-Sleep -Seconds 5

    # Validate the setting
    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName
    if ($currentValue -eq $desiredValue) {
        Write-Output "✅ Validation passed: $valueName is set to $currentValue"
        Write-Output "🎉 Remediation successful."
    } else {
        Write-Warning "❌ Validation failed: $valueName is $currentValue but expected $desiredValue"
        Write-Error "Remediation incomplete."
    }

} catch {
    Write-Error "❌ An error occurred: $_"
}
