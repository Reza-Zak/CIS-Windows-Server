<#
.SYNOPSIS
    CIS Check: 2.3.1.2 - Limit local account use of blank passwords to console logon only

.DESCRIPTION
    Ensures the setting:
        'LimitBlankPasswordUse'
    is ENABLED (1).

    Value meanings:
        0 = Disabled  (NON-compliant)
        1 = Enabled   (CIS compliant)

.NOTES
    Layer: 2
    CIS Level: 1
    Applies to all servers
#>

param()

$script:testTags = @('Level1','Server2019','Server2022','Enabled')

BeforeAll {

    Import-Module BaselineUtils -ErrorAction Stop
    Test-AdminRights

    $script:optionValue = Get-SecurityOptionValue -OptionName 'LimitBlankPasswordUse'
}

Describe "CIS Check: 2.3.1.2 - Limit blank password use to console logon only" -Tag $script:testTags {

    Context "Security Option: LimitBlankPasswordUse" {

        It "Must be enabled (1)" {

            [int]$script:optionValue | Should -Be 1
        }
    }
}
