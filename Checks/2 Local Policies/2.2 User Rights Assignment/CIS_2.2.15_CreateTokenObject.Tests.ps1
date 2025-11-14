<#
.SYNOPSIS
    CIS Check: 2.2.15 - Create a token object

.DESCRIPTION
    Validates that NO users or groups are assigned the
    SeCreateTokenPrivilege user right. This privilege is extremely
    sensitive and should always remain unassigned.

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
    # Load BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdministratorRights

    # Retrieve privilege assignments via module helper
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreateTokenPrivilege'
}

Describe "CIS Check: 2.2.15 - Create a token object" -Tag $script:testTags {
    Context "User right assignment for SeCreateTokenPrivilege" {
        It "Should not be assigned to any user or group" {
            ($script:sidString -eq $null -or $script:sidString -eq '') | Should -BeTrue
        }
    }
}
