<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-CC-000030 by disabling ICMP redirects and rejecting IP source routing to prevent OSPF route overrides.

.DESCRIPTION
This PowerShell script enforces security configurations in alignment with Department of Defense STIG requirement WN10-CC-000030. Specifically, it configures the Windows system to prevent Internet Control Message Protocol (ICMP) redirects from overriding Open Shortest Path First (OSPF) generated routes.
To achieve this, the script modifies the following registry settings:
Path: HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
Value Name: EnableICMPRedirect
Type: REG_DWORD
Value: 0 (Disables acceptance of ICMP redirects)
Path: HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
Value Name: DisableIPSourceRouting
Type: REG_DWORD
Value: 2 (Completely disables source routing)
These changes ensure that Windows systems do not allow route modification by unauthorized ICMP redirects and that source-routed packets are rejected, thereby strengthening network route integrity and reducing the risk of man-in-the-middle (MitM) attacks.
After execution, the script confirms the configuration values have been applied.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000030).ps1 

#>

# This script disables ICMP redirects for all network interfaces
# Requires Administrator privileges
# WN10-CC-000030 - Disable ICMP Redirects to prevent overriding OSPF routes

# Create registry path if it doesn't exist
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
if (-Not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip" -Name "Parameters" -Force
}

# Set values to disable ICMP Redirects and Source Routing
New-ItemProperty -Path $regPath -Name "EnableICMPRedirect" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $regPath -Name "DisableIPSourceRouting" -Value 2 -PropertyType DWord -Force

# Confirm settings
$settings = Get-ItemProperty -Path $regPath | Select-Object EnableICMPRedirect, DisableIPSourceRouting
$settings

Write-Host "WN10-CC-000030 enforced: ICMP redirects disabled, source routing rejected."


