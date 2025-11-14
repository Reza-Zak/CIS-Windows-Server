<#
.SYNOPSIS
    CIS Check: 2.2.20 - Debug programs

.DESCRIPTION
    Validates that only 'Administrators' are assigned the user right
    SeDebugPrivilege. Granting this privilege to non-admin accounts 
    is a major security risk.

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

$script:testTags = @(
    'Level1',
    'Server2019',
    'Server2022',
    'Enabled'
)

BeforeAll {
    # Load your module
    Import-Module BaselineUtils -ErrorAction Stop

    # Require administrative privileges
    Test-AdministratorRights

    # Retrieve SeDebugPrivilege assignments
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeDebugPrivilege'
}

Describe "CIS Check: 2.2.20 - Debug programs" -Tag $script:testTags {
    Context "User right assignment for SeDebugPrivilege" {
        It "Should only include Administrators" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators')

        }
    }
}
