<#
.SYNOPSIS
    CIS Check: 2.2.4 - Act as part of the operating system

.DESCRIPTION
    Ensures that no users or groups are assigned the 
    SeTcbPrivilege user right (Act as part of the operating system),
    which must always remain unassigned.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

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

    # Import BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdminRights

    # Use module helper to get privilege assignment (SID string)
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeTcbPrivilege'
}

Describe "CIS Check: 2.2.4 - Act as part of the operating system" -Tag $script:testTags {

    Context "User right assignment for SeTcbPrivilege" {

        It "Should be assigned to no one" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @()    # Expecting empty
        }
    }
}
