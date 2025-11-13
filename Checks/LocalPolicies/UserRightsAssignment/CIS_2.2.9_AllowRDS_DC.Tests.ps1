<#
.SYNOPSIS
    CIS Check: 2.2.9 - Allow log on through Remote Desktop Services (DC only)

.DESCRIPTION
    Ensures that 'SeRemoteInteractiveLogonRight' is restricted only to:
        - Administrators

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

    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeRemoteInteractiveLogonRight'
}

Describe "CIS Check: 2.2.9 - Allow log on through Remote Desktop Services (DC only)" -Tag $script:testTags {

    Context "Privilege: SeRemoteInteractiveLogonRight" {

        It "Should only include Administrators" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @('BUILTIN\Administrators')
        }
    }
}
