<#
.SYNOPSIS
    CIS Check: 2.3.1.2 - Accounts: Limit local account use of blank passwords to console logon only

.DESCRIPTION
    Ensures blank passwords can only be used for console logons.
    CIS requirement: Value must be 1 (Enabled).

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

    # Retrieve registry-based Security Option
    $script:blankPasswordSetting = Get-SecurityOptionValue -OptionName "LimitBlankPasswordUse"
}

Describe "CIS 2.3.1.2 - Limit blank passwords to console logon only" -Tag $script:testTags {

    Context "Security option: LimitBlankPasswordUse" {

        It "Should be Enabled (1)" {
            [int]$script:blankPasswordSetting | Should -Be 1
        }
    }
}
