<#
.SYNOPSIS
    CIS Check: 2.3.1.4 - Rename Guest account

.DESCRIPTION
    Ensures the built-in Guest account has been renamed from "Guest".
    Reads the Security Option:
        - NewGuestName

.NOTES
    Requires defining expected renamed Guest name.
#>

param()

$script:testTags = @('Level1','Server2019','Server2022','Enabled')

# TODO: Set correct renamed Guest account name for your environment
$expectedGuestName = 'LocalGuest'

BeforeAll {

    Import-Module BaselineUtils
    Test-AdminRights

    $script:guestName = Get-SecurityOptionValue -OptionName 'NewGuestName'
}

Describe "CIS Check: 2.3.1.4 - Rename Guest account" -Tag $script:testTags {

    Context "Security Option: NewGuestName" {

        It "Guest account must be renamed to '$expectedGuestName'" {

            $script:guestName | Should -Be $expectedGuestName
        }
    }
}
