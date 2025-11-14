<#
.SYNOPSIS
    CIS Check: 2.3.1.1 - Accounts: Guest account status (MS Only)

.DESCRIPTION
    Ensures the Guest account is DISABLED.
    This setting corresponds to the security option value:
        - 'EnableGuestAccount'
    Where:
        0 = Disabled   (CIS compliance)
        1 = Enabled    (Non-compliant)

.NOTES
    Layer: 2
    CIS Level: 1
    Role: Member Server only
#>

param()

$script:testTags = @('Level1','Server2019','Server2022','MemberServer','Enabled')

BeforeAll {

    Import-Module BaselineUtils -ErrorAction Stop
    Test-AdminRights

    # Retrieve security option value
    $script:guestStatus = Get-SecurityOptionValue -OptionName 'EnableGuestAccount'
}

Describe "CIS Check: 2.3.1.1 - Guest account status" -Tag $script:testTags {

    Context "Security Option: EnableGuestAccount" {

        It "Guest account MUST be disabled (value = 0)" {

            [int]$script:guestStatus | Should -Be 0
        }
    }
}
