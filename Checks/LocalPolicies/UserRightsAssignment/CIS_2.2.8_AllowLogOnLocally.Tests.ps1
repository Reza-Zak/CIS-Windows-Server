<#
.SYNOPSIS
    CIS Check: 2.2.8 - Allow log on locally

.DESCRIPTION
    Validates that only 'Administrators' are assigned 
    the SeInteractiveLogonRight privilege.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

    Required Tags:
    - Roles: MemberServer
    - Environment: None

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

# Tags for Pester filtering
$script:testTags = @('Level1', 'Server2019', 'Server2022', 'MemberServer', 'Enabled')

BeforeAll {
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdministratorRights

    # Retrieve privilege assignments using the helper function
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeInteractiveLogonRight'
}

Describe "CIS Check: 2.2.8 - Allow log on locally" -Tag $script:testTags {
    Context "User right assignment for SeInteractiveLogonRight" {
        It "Should only include 'Administrators'" {
            Test-PrivilegeAssignments -SidString $script:sidString -ExpectedAccounts @('Administrators')
        }
    }
}
