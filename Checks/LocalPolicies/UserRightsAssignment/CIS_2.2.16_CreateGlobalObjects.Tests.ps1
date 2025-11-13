<#
.SYNOPSIS
    CIS Check: 2.2.16 - Create global objects

.DESCRIPTION
    Validates that only 'Administrators', 'LOCAL SERVICE', 
    'NETWORK SERVICE', and 'SERVICE' are assigned the 
    SeCreateGlobalPrivilege user right.

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
    # Import module
    Import-Module BaselineUtils -ErrorAction Stop

    # Require administrative rights
    Test-AdministratorRights

    # Retrieve privilege assignments using helper
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreateGlobalPrivilege'
}

Describe "CIS Check: 2.2.16 - Create global objects" -Tag $script:testTags {
    Context "User right assignment for SeCreateGlobalPrivilege" {
        It "Should only include Administrators, LOCAL SERVICE, NETWORK SERVICE, and SERVICE" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @(
                    'BUILTIN\Administrators',
                    'NT AUTHORITY\LOCAL SERVICE',
                    'NT AUTHORITY\NETWORK SERVICE',
                    'NT AUTHORITY\SERVICE'
                )
        }
    }
}
