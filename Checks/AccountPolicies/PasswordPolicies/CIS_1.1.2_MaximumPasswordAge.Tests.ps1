<#
.SYNOPSIS
    CIS Check: 1.1.2 - Maximum Password Age

.DESCRIPTION
    This test validates that the system is configured to set maximum password age 
    to 365 or fewer days, but not 0.

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

Describe "CIS Check: 1.1.2 - Maximum Password Age" -Tag $script:testTags {
    Context "Maximum password age policy" {
        It "Should set maximum password age to 365 or fewer days, but not 0" {
            [int]$script:securityPolicy['MaximumPasswordAge'] | Should -BeGreaterThan 0
            [int]$script:securityPolicy['MaximumPasswordAge'] | Should -BeLessOrEqual 365
        }
    }
}
