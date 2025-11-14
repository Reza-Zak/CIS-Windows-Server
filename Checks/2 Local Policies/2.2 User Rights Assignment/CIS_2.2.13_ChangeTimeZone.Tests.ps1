<#
.SYNOPSIS
    CIS Check: 2.2.13 - Change the time zone

.DESCRIPTION
    Validates that only 'Administrators' and 'LOCAL SERVICE'
    are assigned the SeTimeZonePrivilege user right.

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
    # Import BaselineUtils module (installed in PSModulePath)
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative rights
    Test-AdministratorRights

    # Retrieve privilege assignments using the helper function
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeTimeZonePrivilege'
}

Describe "CIS Check: 2.2.13 - Change the time zone" -Tag $script:testTags {
    Context "User right assignment for SeTimeZonePrivilege" {
        It "Should only include 'Administrators' and 'LOCAL SERVICE'" {
            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @(
                    'BUILTIN\Administrators',
                    'NT AUTHORITY\LOCAL SERVICE'
                )
        }
    }
}
