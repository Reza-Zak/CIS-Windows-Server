<#
.SYNOPSIS
    CIS Check: 2.3.1.4 - Rename guest account

.DESCRIPTION
    Ensures that the built-in Guest account has been renamed.
    CIS only requires that it is NOT named "Guest".

.NOTES
    CIS Level: 1
    Automated Check

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

param()

$script:testTags = @("Level1","Server2019","Server2022","Enabled")

BeforeAll {

    Test-AdministratorRights

    # Retrieve the configured Guest account name
    $script:guestName = Get-SecurityOptionValue -OptionName "NewGuestName"
}

Describe "CIS 2.3.1.4 - Rename Guest Account" -Tag $script:testTags {

    Context "Guest account rename policy" {

        It "Should NOT be 'Guest'" {
            $script:guestName | Should -Not -Be "Guest"
        }
    }
}
