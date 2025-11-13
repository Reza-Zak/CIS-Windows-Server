<#
.SYNOPSIS
    CIS Check: 2.2.17 - Create permanent shared objects

.DESCRIPTION
    Validates that no users or groups are assigned the user right 
    SeCreatePermanentPrivilege. This privilege is extremely sensitive 
    and must not be granted to any account.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

    Required Tags:
    - Roles: None
    - Environment: None

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments','')]
param()

# Tags for Pester filtering
$script:testTags = @(
    'Level1',
    'Server2019',
    'Server2022',
    'Enabled'
)

BeforeAll {
    # Load BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Require admin rights
    Test-AdministratorRights

    # Retrieve privilege assignments for SeCreatePermanentPrivilege
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreatePermanentPrivilege'
}

Describe "CIS Check: 2.2.17 - Create permanent shared objects" -Tag $script:testTags {
    Context "User right assignment for SeCreatePermanentPrivilege" {
        It "Should not be assigned to any users or groups" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @()     # Expecting NONE

        }
    }
}
