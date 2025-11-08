<#
.SYNOPSIS
    CIS Check: 1.1.3 - Minimum Password Age

.DESCRIPTION
    This test validates that the system is configured to enforce 
    a minimum password age of 1 or more days.

.NOTES
    Layer: 1
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

    Required Tags:
    - Roles: None
    - Environment: None

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

# Tags for Pester filtering
$script:testTags = @('Level1','Server2019','Server2022','Enabled')

BeforeAll {
    # Import BaselineUtils module (installed in PSModulePath)
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrator privileges
    Test-AdministratorRights

    # Create a temporary test data directory
    $script:testDataPath = New-TestDataDirectory -RootPath $PSScriptRoot

    # Define output file for secedit export
    $script:seceditOutput = Join-Path $script:testDataPath "secedit.cfg"

    # Export current security policy
    Export-SecurityPolicy -OutputPath $script:seceditOutput

    # Parse security policy into a hashtable
    $script:securityPolicy = Get-SecurityPolicy -FilePath $script:seceditOutput
}

AfterAll {
    # Clean up test data directory
    Remove-TestDataDirectory -Path $script:testDataPath
}

Describe "CIS Check: 1.1.3 - Minimum Password Age" -Tag $script:testTags {
    Context "Minimum password age policy" {
        It "Should be set to 1 or more day(s)" {
            [int]$script:securityPolicy['MinimumPasswordAge'] | Should -BeGreaterOrEqual 1
        }
    }
}
