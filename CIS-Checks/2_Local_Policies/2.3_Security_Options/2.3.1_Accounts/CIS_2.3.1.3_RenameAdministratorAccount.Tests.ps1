<#
.SYNOPSIS
    CIS Check: 2.3.1.3 - Rename administrator account

.DESCRIPTION
    Ensures that the built-in Administrator account has been renamed.
    CIS does not enforce a specific name, only that it is NOT "Administrator".

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

    # Retrieve the configured name of the built-in Administrator account
    $script:adminName = Get-SecurityOptionValue -OptionName "NewAdministratorName"
}

Describe "CIS 2.3.1.3 - Rename Administrator Account" -Tag $script:testTags {

    Context "Administrator account must be renamed" {

        It "Should NOT be 'Administrator'" {
            $script:adminName | Should -Not -Be "Administrator"
        }
    }
}
