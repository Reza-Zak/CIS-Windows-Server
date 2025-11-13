<#
.SYNOPSIS
    CIS Check: 2.2.7 - Allow log on locally (DC only)

.DESCRIPTION
    Ensures that 'SeInteractiveLogonRight' is assigned only to:
        - Administrators
        - ENTERPRISE DOMAIN CONTROLLERS
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

    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeInteractiveLogonRight'
}

Describe "CIS Check: 2.2.7 - Allow log on locally (DC only)" -Tag $script:testTags {

    Context "Privilege: SeInteractiveLogonRight" {

        It "Should include Administrators and Enterprise Domain Controllers" {

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts @(
                    'BUILTIN\Administrators',
                    'NT AUTHORITY\ENTERPRISE DOMAIN CONTROLLERS'
                )
        }
    }
}
