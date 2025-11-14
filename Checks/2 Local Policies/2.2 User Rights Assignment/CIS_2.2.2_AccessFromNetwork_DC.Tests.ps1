<#
.SYNOPSIS
    CIS Check: 2.2.2 - Access this computer from the network (DC only)

.DESCRIPTION
    Ensures that the privilege 'SeNetworkLogonRight' is assigned only to:
        - Administrators
        - Authenticated Users
        - ENTERPRISE DOMAIN CONTROLLERS
    on Domain Controllers.

.NOTES
    Layer: 2
    CIS Level: 1
    OS: Server 2019 / 2022 Domain Controllers only
#>

param()

# Tags for Pester filtering
$script:testTags = @('Level1','DC','Server2019','Server2022','Enabled')

BeforeAll {

    # Load BaselineUtils functions
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure test is running elevated
    Test-AdminRights

    # Get raw privilege SID string from Local Security Policy
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeNetworkLogonRight'
}

Describe "CIS Check: 2.2.2 - Access this computer from the network (DC only)" -Tag $script:testTags {

    Context "Privilege: SeNetworkLogonRight" {

        It "Should include only Administrators, Authenticated Users, and Enterprise Domain Controllers" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @(
                    'BUILTIN\Administrators',
                    'NT AUTHORITY\Authenticated Users',
                    'NT AUTHORITY\ENTERPRISE DOMAIN CONTROLLERS'
                )
        }
    }
}
