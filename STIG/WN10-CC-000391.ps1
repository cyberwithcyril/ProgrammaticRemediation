<#
.SYNOPSIS
Disables Internet Explorer 11 as a standalone browser in compliance with STIG ID WN10-CC-000391.

.DESCRIPTION
This script enforces the security configuration required by the Department of Defense Security Technical Implementation Guide (STIG) for Windows 10 (WN10-CC-000391). 
It disables Internet Explorer 11 as a standalone browser by configuring the appropriate registry settings through Group Policy.
This helps reduce attack surface by preventing users from launching IE11 directly, aligning with modern security practices and Microsoft’s deprecation of Internet Explorer.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000391

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000391).ps1 

#>

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run with administrator privileges to modify system settings."
    exit 1
}

try {
    # Define the registry path for the Internet Explorer policy setting
    $RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"

    # Create the necessary registry keys if they do not exist
    if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
    }
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }

    # Set the registry value to disable IE11 as a standalone browser and set notification to "Never"
    Set-ItemProperty -Path $RegPath -Name "NotifyDisableIEOptions" -Value 0 -Force -ErrorAction Stop

    Write-Host "Successfully configured 'Disable Internet Explorer 11 as a standalone browser' to 'Enabled' (with 'Never' notification)."
    Write-Host "STIG WN10-CC-000391 remediation applied."

    # Force a Group Policy update for immediate effect (if applicable in a domain environment)
    gpupdate /force | Out-Null

} catch {
    Write-Error "Failed to apply STIG WN10-CC-000391 remediation: $($_.Exception.Message)"
}
