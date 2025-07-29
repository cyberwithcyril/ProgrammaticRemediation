<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-CC-000020 by disabling IPv6 source routing to provide highest protection against spoofing attacks.

.DESCRIPTION
This PowerShell script enforces security settings in alignment with the Department of Defense STIG requirement WN10-CC-000020. 
It configures the Windows system to reject all IPv6 source-routed packets, providing maximum protection from packet spoofing 
and route manipulation.

To accomplish this, the script sets the following registry value:
Path: HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters
Value Name: DisableIPSourceRouting
Type: REG_DWORD
Value: 2 (Highest protection — completely disables source routing)

This setting ensures IPv6 source routing is fully disabled, mitigating the risk of attackers redirecting traffic or injecting malicious routes. 
After execution, the script verifies and reports the applied configuration to ensure compliance.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000020).ps1 
#>


# Set IPv6 source routing to 'Highest Protection' (completely disabled)
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$propertyName = "DisableIPSourceRouting"
$desiredValue = 2

# Create the key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $regPath -Name $propertyName -PropertyType DWord -Value $desiredValue -Force

# Verify the change
Get-ItemProperty -Path $regPath | Select-Object $propertyName

# Optional: Restart the computer to apply settings
Restart-Computer -Force

