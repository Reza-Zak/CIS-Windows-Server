<#
.SYNOPSIS
    Retrieves privilege assignment settings from a parsed security policy.

.DESCRIPTION
    Scans a parsed secedit.cfg hashtable for keys that represent privilege
    assignments (e.g., SeRemoteInteractiveLogonRight) and returns them.

.PARAMETER SecurityPolicy
    A hashtable returned by Get-SecurityPolicy.

.EXAMPLE
    $privileges = Get-PrivilegeAssignments -SecurityPolicy $policy
#>
function Get-PrivilegeAssignments {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [hashtable]$SecurityPolicy
    )

    $privileges = @{}
    foreach ($key in $SecurityPolicy.Keys) {
        if ($key -like "Se*Privilege") {
            $privileges[$key] = $SecurityPolicy[$key]
        }
    }
    return $privileges
}
