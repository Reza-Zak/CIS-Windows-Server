<#
.SYNOPSIS
    CIS Check: 2.2.21 - Deny access to this computer from the network (DC only)

.DESCRIPTION
    Ensures that 'SeDenyNetworkLogonRight' includes:
        - Guests
    This helps prevent unauthorized network access.

.NOTES
    Layer: 2
    CIS Level: 1
    OS: Server 2019 / 2022 Domain Controllers only
#>

param()

$script:testTags = @('Level1','DC','Server2019','Server2022','Enabled')

BeforeAll {

    Import-Module BaselineUtils -ErrorAction Stop
    Test-AdminRights

    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeDenyNetworkLogonRight'
}

Describe "CIS Check: 2.2.21 - Deny access to this computer from the network (DC only)" -Tag $script:testTags {

    Context "Privilege: SeDenyNetworkLogonRight" {

        It "Should include Guests" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Guests')
        }
    }
}
