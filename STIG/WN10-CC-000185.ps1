<#
.SYNOPSIS
Ensures compliance with STIG WN10-CC-000185 by configuring Windows 10 to prevent the execution of autorun commands.

.DESCRIPTION
This PowerShell script disables the default autorun behavior by setting registry values that block autorun commands from executing on all drive types.
This is in accordance with the Department of Defense STIG requirement WN10-CC-000185, which mitigates the risk of malware propagation via removable media.


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000185).ps1 


# Registry path for disabling Autorun
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$propertyName = "NoAutorun"
$propertyValue = 1

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set NoAutorun to 1 (prevent autorun)
Set-ItemProperty -Path $regPath -Name $propertyName -Value $propertyValue -Type DWord

# Also enforce NoDriveTypeAutoRun = 255 to disable all autorun
Set-ItemProperty -Path $regPath -Name "NoDriveTypeAutoRun" -Value 255 -Type DWord

Write-Output "✅ Autorun behavior has been disabled as required by STIG WN10-CC-000185."
