<#
.SYNOPSIS
    CIS Check: 2.2.18 - Create symbolic links (DC only)

.DESCRIPTION
    Ensures the privilege 'SeCreateSymbolicLinkPrivilege' is assigned only to:
        - Administrators
    on Domain Controllers.

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

    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreateSymbolicLinkPrivilege'
}

Describe "CIS Check: 2.2.18 - Create symbolic links (DC only)" -Tag $script:testTags {

    Context "Privilege: SeCreateSymbolicLinkPrivilege" {

        It "Should only include Administrators" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators')
        }
    }
}
