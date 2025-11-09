<#
.SYNOPSIS
    CIS Check: 2.2.6 - Adjust memory quotas for a process

.DESCRIPTION
    Validates that only 'Administrators', 'LOCAL SERVICE', and 'NETWORK SERVICE'
    are assigned the SeIncreaseQuotaPrivilege user right.

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

# Tags for Pester filtering
$script:testTags = @('Level1', 'Server2019', 'Server2022', 'Enabled')

BeforeAll {
    # Import BaselineUtils module (installed in PSModulePath)
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative privileges
    Test-AdministratorRights

    # Retrieve privilege assignments using helper
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeIncreaseQuotaPrivilege'
}

Describe "CIS Check: 2.2.6 - Adjust memory quotas for a process" -Tag $script:testTags {
    Context "User right assignment for SeIncreaseQuotaPrivilege" {
        It "Should only include 'Administrators', 'LOCAL SERVICE', and 'NETWORK SERVICE'" {
            Test-PrivilegeAssignments -SidString $script:sidString -ExpectedAccounts @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE')
        }
    }
}
