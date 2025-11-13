<#
.SYNOPSIS
    CIS Check: 1.1.1 - Enforce Password History

.DESCRIPTION
    Validates that the system enforces password history of 24 or more passwords.

.NOTES
    Layer: 1
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server 2022

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

# Pester tag filters
$script:testTags = @(
    'Level1',
    'Server2019',
    'Server2022',
    'Enabled'
)

BeforeAll {

    # Load BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Require admin privileges
    Test-AdminRights

    # Create TestData directory (via module helper)
    $script:testDataPath = Initialize-TestDataDirectory -RootPath $PSScriptRoot

    # Export local security policy → secedit.cfg
    $script:seceditOutput = Join-Path $script:testDataPath 'secedit.cfg'
    Export-SecurityPolicy -OutputPath $script:seceditOutput

    # Parse the security policy into a hashtable
    $script:securityPolicy = Get-SecurityPolicy -FilePath $script:seceditOutput
}

AfterAll {
    # Cleanup TestData directory via module helper
    Remove-TestDataDirectory -Path $script:testDataPath
}

Describe "CIS Check: 1.1.1 - Enforce Password History" -Tag $script:testTags {
    Context "Password history configuration" {
        It "Should enforce password history of 24 or more passwords" {

            [int]$script:securityPolicy['PasswordHistorySize'] |
                Should -BeGreaterOrEqual 24

        }
    }
}
