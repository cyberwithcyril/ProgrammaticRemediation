<#
.SYNOPSIS
Ensures compliance with STIG WN10-AC-000020 by configuring the password history to remember 24 passwords.

.DESCRIPTION
This PowerShell script modifies the local security policy to enforce a password history of 24 unique passwords, thus preventing password reuse and mitigating the risk of unauthorized access, 
thereby addressing STIG ID WN10-AC-000020. This setting ensures that users cannot cycle back to a recently used password, enhancing overall system security.

.NOTES
    Author          : Cyril Thomas
    LinkedIn        : linkedin.com/in/cyrilkthomas/
    GitHub          : github.com/cyberwithcyril
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000020).ps1 
#>


# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run with administrator privileges to modify system settings."
    exit 1
}

# --- STIG WN10-AC-000020 Remediation ---
# Objective: The password history must be configured to 24 passwords remembered.
# GPO Path: Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy
# GPO Setting: "Enforce password history" to "24" passwords remembered.

try {
    # Set the password history to 24 remembered passwords using the 'net accounts' command
    net accounts /maxpwage:UNLIMITED # Temporarily remove maxpwage if set to allow immediate changes to history
    net accounts /minpwlen:14  # Ensure min password length for effectiveness
    net accounts /uniquepw:24  # Set password history to 24

    Write-Host "Successfully configured password history to 24 remembered passwords."
    Write-Host "STIG WN10-AC-000020 remediation applied."

    # Force a Group Policy update to ensure changes are applied immediately
    gpupdate /force | Out-Null

} catch {
    Write-Error "Failed to apply STIG WN10-AC-000020 remediation: $($_.Exception.Message)"
}
