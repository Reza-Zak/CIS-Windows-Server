<#
.SYNOPSIS
    CIS Check: 2.2.3 - Access this computer from the network (Member Servers)

.DESCRIPTION
    Validates that only 'Administrators' and 'Authenticated Users'
    are assigned the SeNetworkLogonRight privilege.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

    Required Tags:
    - Roles: MemberServer
    - Environment: None

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

# Pester tags
$script:testTags = @('Level1', 'Server2019', 'Server2022', 'MemberServer', 'Enabled')

BeforeAll {
    # Import the BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Verify the user has administrative privileges
    Test-AdministratorRights

    # Retrieve privilege assignments using the helper function
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeNetworkLogonRight'
}

Describe "CIS Check: 2.2.3 - Access this computer from the network (MS)" -Tag $script:testTags {
    Context "User right assignment for SeNetworkLogonRight" {
        It "Should only include 'Administrators' and 'Authenticated Users'" {
            Test-PrivilegeAssignments -SidString $script:sidString -ExpectedAccounts @('Administrators', 'Authenticated Users')
        }
    }
}
