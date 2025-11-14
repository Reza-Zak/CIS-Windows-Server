<#
.SYNOPSIS
    CIS Check: 2.3.1.1 - Accounts: Guest account status

.DESCRIPTION
    Validates that the Guest account is disabled.
    CIS requirement: Value must be 0 (Disabled).

.NOTES
    CIS Level: 1
    Role: Member Server only
    Automated Check

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

param()

$script:testTags = @("Level1","Server2019","Server2022","MemberServer","Enabled")

BeforeAll {

    # Ensure test is running with administrative privileges
    Test-AdministratorRights

    # Retrieve SECPOL-based security option using module function
    $script:guestStatus = Get-SecurityOptionValue -OptionName "EnableGuestAccount"
}

Describe "CIS 2.3.1.1 - Accounts: Guest account status" -Tag $script:testTags {

    Context "Guest account must be disabled" {

        It "Should be set to Disabled (0)" {
            [int]$script:guestStatus | Should -Be 0
        }
    }
}
