<#
.SYNOPSIS
    CIS Check: 2.3.1.3 - Rename Administrator account

.DESCRIPTION
    Ensures the built-in Administrator account has been renamed from "Administrator".
    Reads the Security Option:
        - NewAdministratorName

.NOTES
    Requires defining the expected renamed account name in this script.
#>

param()

$script:testTags = @('Level1','Server2019','Server2022','Enabled')

# TODO: Set the expected Administrator rename value for your environment
$expectedAdminName = 'LocalAdmin'

BeforeAll {

    Import-Module BaselineUtils -ErrorAction Stop
    Test-AdminRights

    $script:adminName = Get-SecurityOptionValue -OptionName 'NewAdministratorName'
}

Describe "CIS Check: 2.3.1.3 - Rename Administrator account" -Tag $script:testTags {

    Context "Security Option: NewAdministratorName" {

        It "Administrator account MUST be renamed to '$expectedAdminName'" {

            $script:adminName | Should -Be $expectedAdminName
        }
    }
}
