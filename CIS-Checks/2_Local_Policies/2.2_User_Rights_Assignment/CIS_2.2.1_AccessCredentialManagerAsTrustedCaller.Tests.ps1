<#
.SYNOPSIS
    CIS Check: 2.2.1 - Access Credential Manager as a trusted caller

.DESCRIPTION
    This test validates that NO users or groups are assigned the 
    SeTrustedCredManAccessPrivilege user right.

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

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

$script:testTags = @('Level1','Server2019','Server2022','Enabled')

BeforeAll {
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdministratorRights

    # Retrieve assignments using helper
    $script:assigned = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeTrustedCredManAccessPrivilege'
}

Describe "CIS Check: 2.2.1 - Access Credential Manager as a trusted caller" -Tag $script:testTags {
    Context "Privilege assignment policy" {
        It "Should have NO assigned users or groups" {
            ($script:assigned -eq $null -or $script:assigned -eq '') | Should -BeTrue
        }
    }
}

