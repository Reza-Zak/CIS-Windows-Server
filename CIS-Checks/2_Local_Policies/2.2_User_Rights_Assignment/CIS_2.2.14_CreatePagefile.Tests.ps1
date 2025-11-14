<#
.SYNOPSIS
    CIS Check: 2.2.14 - Create a pagefile

.DESCRIPTION
    Validates that only 'Administrators' are assigned the 
    SeCreatePagefilePrivilege user right.

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

$script:testTags = @(
    'Level1',
    'Server2019',
    'Server2022',
    'Enabled'
)

BeforeAll {
    # Import BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdministratorRights

    # Retrieve privilege assignments using convenience helper
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreatePagefilePrivilege'
}

Describe "CIS Check: 2.2.14 - Create a pagefile" -Tag $script:testTags {
    Context "User right assignment for SeCreatePagefilePrivilege" {
        It "Should only include 'Administrators'" {
            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators')
        }
    }
}
