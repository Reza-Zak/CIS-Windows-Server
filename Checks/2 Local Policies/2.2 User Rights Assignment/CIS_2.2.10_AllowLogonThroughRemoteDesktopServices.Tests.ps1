<#
.SYNOPSIS
    CIS Check: 2.2.10 - Allow log on through Remote Desktop Services

.DESCRIPTION
    Validates that only 'Administrators' and 'Remote Desktop Users' 
    are assigned the SeRemoteInteractiveLogonRight privilege.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2022

    Required Tags:
    - Roles: MemberServer
    - Environment: None

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

# Tags for Pester filtering
$script:testTags = @('Level1', 'Server2022', 'MemberServer', 'Enabled')

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

    # Retrieve privilege assignments for SeRemoteInteractiveLogonRight
    $script:sidString = Get-PrivilegeAssignments -FilePath $script:seceditOutput -PrivilegeName 'SeRemoteInteractiveLogonRight'
}

AfterAll {
    # Clean up temporary directory
    Remove-TestDataDirectory -Path $script:testDataPath
}

Describe "CIS Check: 2.2.10 - Allow log on through Remote Desktop Services" -Tag $script:testTags {
    Context "User right assignment for SeRemoteInteractiveLogonRight" {
        It "Should include only 'Administrators' and 'Remote Desktop Users'" {
            Test-PrivilegeAssignments -SidString $script:sidString -ExpectedAccounts @('Administrators', 'Remote Desktop Users')
        }
    }
}
