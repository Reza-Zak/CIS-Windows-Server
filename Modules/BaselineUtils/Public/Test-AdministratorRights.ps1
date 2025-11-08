<#
.SYNOPSIS
    Verifies the current PowerShell session has administrative privileges.

.DESCRIPTION
    This function checks whether the user running the script has elevated
    administrative rights. It throws a terminating error if the session
    is not elevated, preventing tests from running in non-admin mode.

.EXAMPLE
    Test-AdministratorRights

.NOTES
    Author: RBA
    Version: 1.3.1
#>
function Test-AdministratorRights {
    [CmdletBinding()]
    param ()

    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        throw "Administrator privileges are required to run this test."
    }
}
