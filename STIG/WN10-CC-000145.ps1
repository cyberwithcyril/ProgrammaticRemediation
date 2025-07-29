<#
.SYNOPSIS
Ensures compliance with STIG WN10-CC-000145 by requiring a password prompt on resume from sleep while the system is running on battery power.

.DESCRIPTION
This PowerShell script configures the Windows 10 system to prompt for a password when resuming from sleep on battery.
It modifies the appropriate power policy setting to meet the DoD security requirement defined in STIG WN10-CC-000145, helping to prevent unauthorized access when a system is unattended.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000145).ps1 

#>

.SYNOPSIS
Ensures compliance with STIG WN10-CC-000145 by enabling password prompt on wake from sleep while on battery.

.DESCRIPTION
Uses powercfg.exe to set the 'Require a password on wakeup' setting to 'Yes' (value: 1) for battery mode.
#>

# Paths and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valuesToSet = @{
    "DCSettingIndex" = 1
    "ACSettingIndex" = 1
}

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    Write-Output "Creating registry path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the required values
foreach ($name in $valuesToSet.Keys) {
    Write-Output "Setting $name to $($valuesToSet[$name])"
    Set-ItemProperty -Path $registryPath -Name $name -Value $valuesToSet[$name] -Type DWord
}

# Force Group Policy update to apply changes immediately
Write-Output "Running gpupdate /force to apply policy changes..."
gpupdate /force | Out-Null

Start-Sleep -Seconds 5 # wait a bit for policy to apply

# Validate the changes
$props = Get-ItemProperty -Path $registryPath
$allSet = $true

foreach ($name in $valuesToSet.Keys) {
    if ($props.$name -ne $valuesToSet[$name]) {
        Write-Warning "Validation failed: $name is $($props.$name), expected $($valuesToSet[$name])"
        $allSet = $false
    } else {
        Write-Output "Validation passed: $name = $($props.$name)"
    }
}

if ($allSet) {
    Write-Output "`n✅ Remediation successful: Require a password on wakeup is enabled for battery and AC."
} else {
    Write-Error "`n❌ Remediation incomplete: One or more settings did not apply correctly."
}
