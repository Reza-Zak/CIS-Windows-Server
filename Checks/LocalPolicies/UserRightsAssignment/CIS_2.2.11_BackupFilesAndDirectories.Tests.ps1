<#
.SYNOPSIS
    CIS Check: 2.2.11 - Back up files and directories

.DESCRIPTION
    Validates that only 'Administrators' are assigned the SeBackupPrivilege user right.

.NOTES
    Layer: 2
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
$script:testTags = @('Level1', 'Server2019', 'Server2022', 'Enabled')

BeforeAll {
    # Import BaselineUtils module (installed in PSModulePath)
    Import-Module BaselineUtils -ErrorAction Stop

    # Ensure administrative privileges
    Test-AdministratorRights

    # Create temporary test data directory
    $script:testDataPath = New-TestDataDirectory -RootPath $PSScriptRoot

    # Export current security policy to secedit.inf
    $script:seceditOutput = Join-Path $script:testDataPath "secedit.inf"
    Export-SecurityPolicy -OutputPath $script:seceditOutput

    # Retrieve privilege assignments for SeBackupPrivilege
    $script:sidString = Get-PrivilegeAssignments -FilePath $script:seceditOutput -PrivilegeName 'SeBackupPrivilege'
}

AfterAll {
    # Clean up temporary directory
    Remove-TestDataDirectory -Path $script:testDataPath
}

Describe "CIS Check: 2.2.11 - Back up files and directories" -Tag $script:testTags {
    Context "User right assignment for SeBackupPrivilege" {
        It "Should include only 'Administrators'" {
            # Validate privilege assignments using BaselineUtils helper
            Test-PrivilegeAssignments -SidString $script:sidString -ExpectedAccounts @('Administrators')
        }
    }
}
