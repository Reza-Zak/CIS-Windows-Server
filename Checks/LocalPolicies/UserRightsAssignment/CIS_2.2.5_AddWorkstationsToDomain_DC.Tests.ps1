<#
.SYNOPSIS
    CIS Check: 2.2.5 - Add workstations to domain (DC only)

.DESCRIPTION
    Ensures that 'SeMachineAccountPrivilege' is restricted to:
        - Administrators
    This privilege must remain tightly controlled on Domain Controllers.

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

    # Retrieve privilege assignments from secedit export
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeMachineAccountPrivilege'
}

Describe "CIS Check: 2.2.5 - Add workstations to domain (DC only)" -Tag $script:testTags {

    Context "Privilege: SeMachineAccountPrivilege" {

        It "Should only include Administrators" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators')
        }
    }
}
