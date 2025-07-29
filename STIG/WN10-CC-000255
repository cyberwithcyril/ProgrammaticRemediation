<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-CC-000255 by enforcing the use of a hardware-based security device (TPM) for Windows Hello for Business.

.DESCRIPTION
This PowerShell script configures Windows 10 systems to comply with the Department of Defense STIG requirement WN10-CC-000255. 
It ensures that Windows Hello for Business is set to require a hardware-based security device, such as a Trusted Platform Module (TPM), 
enhancing credential protection by tying authentication to physical hardware.

The script creates or modifies the following registry key and value:
Path: HKLM\SOFTWARE\Policies\Microsoft\PassportForWork  
Value Name: RequireSecurityDevice  
Type: REG_DWORD  
Value: 1 (Enabled — requires a hardware security device)

By enforcing this setting, the system helps prevent credential theft and ensures biometric and PIN authentication are backed by secure hardware. 
After setting the registry value, the script optionally initiates a group policy update to apply the changes immediately.



.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000255).ps1 
#>

# Set the registry path for Windows Hello for Business policy
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"

# Set the registry value name
$ValueName = "RequireSecurityDevice"

# Set the desired value (1 for Enabled - requiring hardware security device)
$ValueData = 1

# Check if the registry key exists, if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Host "Created registry key: $RegistryPath"
}

# Set the registry value
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Force

Write-Host "Registry value '$ValueName' set to '$ValueData' at '$RegistryPath'."
Write-Host "Windows Hello for Business is now configured to require a hardware security device (TPM)."

# Force Group Policy update to apply the changes (optional, but recommended)
gpupdate /force
