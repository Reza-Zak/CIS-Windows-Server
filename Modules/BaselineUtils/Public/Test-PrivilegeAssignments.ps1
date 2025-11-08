<#
.SYNOPSIS
    Validates system privilege assignments against expected CIS benchmark values.

.DESCRIPTION
    Compares current privilege assignments from the local system against
    expected CIS benchmark values and reports any deviations.

.PARAMETER CurrentAssignments
    Hashtable of privileges from Get-PrivilegeAssignments.

.PARAMETER ExpectedAssignments
    Hashtable containing expected benchmark values.

.EXAMPLE
    Test-PrivilegeAssignments -CurrentAssignments $current -ExpectedAssignments $expected
#>
function Test-PrivilegeAssignments {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [hashtable]$CurrentAssignments,

        [Parameter(Mandatory)]
        [hashtable]$ExpectedAssignments
    )

    $results = @()

    foreach ($privilege in $ExpectedAssignments.Keys) {
        $expected = $ExpectedAssignments[$privilege]
        $actual   = $CurrentAssignments[$privilege]

        if ($actual -ne $expected) {
            $results += [PSCustomObject]@{
                Privilege = $privilege
                Expected  = $expected
                Actual    = $actual
                Status    = 'NonCompliant'
            }
        }
    }

    return $results
}
