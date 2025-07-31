<#
.SYNOPSIS
Ensures compliance with STIG ID WN10-CC-000305 by disabling indexing of encrypted files.

.DESCRIPTION
This PowerShell script enforces the STIG requirement WN10-CC-000305 on Windows 10 systems.
It modifies the registry to ensure that encrypted files are excluded from being indexed 
by the Windows Search service, which helps prevent accidental data leakage and ensures 
sensitive content remains secure. This setting enhances protection of data-at-rest 
on systems that use the Windows Encrypting File System (EFS)


.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000305

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000305).ps1 

#>

# WN10-CC-000305 Remediation Script
# Indexing of encrypted files must be turned off

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Run as Administrator"
    exit 1
}

# Disable indexing of encrypted files
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }

Set-ItemProperty -Path $path -Name "AllowIndexingEncryptedStoresOrItems" -Value 0 -Type DWord

Write-Host "WN10-CC-000305 remediated - Indexing of encrypted files disabled" -ForegroundColor Green
