<#
.SYNOPSIS
Ensures compliance with STIG WN10-CC-000110 by disabling printing over HTTP on Windows 10 systems.

.DESCRIPTION
This PowerShell script enforces the security requirement to prevent printing over HTTP by setting the registry key 
'DisableHTTPPrinting' to 1 under 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers'. 
This mitigates risks associated with insecure printing protocols as specified in the STIG.
The script creates the necessary registry path if it does not exist and verifies the setting after execution.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000110).ps1 
    
#>
$keyPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Printers"

# Create the key if missing
if (-not (Test-Path $keyPath)) {
    New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows NT" -Name "Printers" -Force
}

# Set the DisableHTTPPrinting DWORD to 1
Set-ItemProperty -Path $keyPath -Name "DisableHTTPPrinting" -Value 1 -Type DWord -Force

# Verify
Get-ItemProperty -Path $keyPath | Select-Object DisableHTTPPrinting

