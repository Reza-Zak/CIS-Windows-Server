<#
.SYNOPSIS
    Converts one or more Security Identifiers (SIDs) to account names.

.DESCRIPTION
    Uses .NET’s SecurityIdentifier class to translate SIDs to
    corresponding NT account names. Unresolvable SIDs are prefixed
    with "Unresolved:" in the result.

.PARAMETER SIDs
    Array of SIDs to resolve.

.EXAMPLE
    Convert-SIDToName -SIDs @('S-1-5-18', 'S-1-5-32-544')
#>
function Convert-SIDToName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$SIDs
    )

    $resolved = @()
    foreach ($sid in $SIDs) {
        try {
            $resolved += (New-Object System.Security.Principal.SecurityIdentifier($sid)).Translate([System.Security.Principal.NTAccount]).Value
        }
        catch {
            $resolved += "Unresolved:$sid"
        }
    }
    return $resolved
}
