<#
.SYNOPSIS
Ensures compliance with STIG WN10-AC-000005 by configuring the Account Lockout Duration to 15 minutes or greater on Windows 10 systems.

.DESCRIPTION
This PowerShell script sets the Account Lockout Duration to a minimum of 15 minutes to comply with DoD security requirements defined in the STIG.
It uses the 'net accounts' command to apply the setting locally and verifies the result after execution.
#>

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

# Configure STIG-compliant Account Lockout Policy on Windows 10

# Set Lockout Duration to 15 minutes
net accounts /lockoutduration:15

# Set Lockout Threshold to 5 invalid logon attempts
net accounts /lockoutthreshold:5

# Set Lockout Window (reset counter) to 15 minutes
net accounts /lockoutwindow:15

# Confirm settings
Write-Host "`n✔️ Account lockout policy has been configured:"
net accounts
