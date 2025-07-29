<#
.SYNOPSIS
Ensures compliance with STIG WN10-CC-000355 by disallowing WinRM from storing RunAs credentials.

.DESCRIPTION
This PowerShell script configures the Windows Remote Management (WinRM) service to prevent it from storing RunAs credentials, addressing STIG ID WN10-CC-000355. 
This is achieved by setting a specific registry value, which corresponds to the Group Policy setting "Computer Configuration/Administrative Templates/Windows Components/Windows Remote Management
(WinRM)/WinRM Service/Disallow WinRM from storing RunAs credentials" to "Enabled". This action prevents the WinRM service from caching sensitive RunAs user credentials, enhancing the security
posture of the system.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000355

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000355).ps1 
#>

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run with administrator privileges to modify system settings."
    exit 1
}

# --- STIG WN10-CC-000355 Remediation ---
# Objective: The Windows Remote Management (WinRM) service must not store RunAs credentials.
# GPO Path: Computer Configuration\Administrative Templates\Windows Components\Windows Remote Management (WinRM)\WinRM Service
# GPO Setting: "Disallow WinRM from storing RunAs credentials" to "Enabled".
# Registry Key: HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\
# Value Name: DisableRunAs
# Value Type: REG_DWORD
# Value Data: 1 (Enabled - Disallow WinRM from storing RunAs credentials)

try {
    # Define the registry path for the WinRM service policy setting
    $RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"

    # Create the necessary registry keys if they do not exist
    if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM" -Force | Out-Null
    }
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }

    # Set the registry value to disallow WinRM from storing RunAs credentials
    Set-ItemProperty -Path $RegPath -Name "DisableRunAs" -Value 1 -Force -ErrorAction Stop

    Write-Host "Successfully configured WinRM to disallow storing of RunAs credentials."
    Write-Host "STIG WN10-CC-000355 remediation applied."

    # Force a Group Policy update for immediate effect (if applicable in a domain environment)
    gpupdate /force | Out-Null

} catch {
    Write-Error "Failed to apply STIG WN10-CC-000355 remediation: $($_.Exception.Message)"
}
