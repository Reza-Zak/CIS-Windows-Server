<#
.SYNOPSIS
    CIS Check: 2.2.12 - Change the system time

.DESCRIPTION
    Verifies that only 'Administrators' and 'LOCAL SERVICE' are granted
    the SeSystemtimePrivilege user right. Restricting this privilege helps
    maintain the integrity of system logs and prevents time-based attacks.

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

$script:testTags = @('Level1','Server2019','Server2022','Enabled')

BeforeAll {
    # Import BaselineUtils module (installed in PSModulePath)
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative privileges
    Test-AdministratorRights

    # Retrieve SeSystemtimePrivilege assignments using the helper
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeSystemtimePrivilege'
}

Describe "CIS Check: 2.2.12 - Change the system time" -Tag $script:testTags {
    Context "User right assignment for SeSystemtimePrivilege" {
        It "Should only include 'Administrators' and 'LOCAL SERVICE'" {
            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators', 'NT AUTHORITY\LOCAL SERVICE')
        }
    }
}
