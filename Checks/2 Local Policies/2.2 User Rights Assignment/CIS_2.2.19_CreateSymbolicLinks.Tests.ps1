<#
.SYNOPSIS
    CIS Check: 2.2.19 - Create symbolic links

.DESCRIPTION
    This test verifies that:
      - If the Hyper-V role is installed, SeCreateSymbolicLinkPrivilege 
        is assigned to 'Administrators' and 'NT VIRTUAL MACHINE\Virtual Machines'.
      - Otherwise, only 'Administrators' should be assigned this privilege.

.NOTES
    Layer: 2
    CIS Controls:
    - Level 1
    - OS Version: Server2019, Server2022

.LINK
    https://www.cisecurity.org/benchmark/windows_server
#>

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments','')]
param()

$script:testTags = @(
    'Level1',
    'Server2019',
    'Server2022',
    'Enabled'
)

BeforeAll {
    # Load BaselineUtils module
    Import-Module BaselineUtils -ErrorAction Stop

    # Require admin rights
    Test-AdministratorRights

    # Determine if Hyper-V is installed
    $script:hyperVInstalled = (Get-WindowsFeature -Name Hyper-V).InstallState -eq 'Installed'

    # Retrieve raw privilege assignment
    $script:sidString = Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeCreateSymbolicLinkPrivilege'
}

Describe "CIS Check: 2.2.19 - Create symbolic links" -Tag $script:testTags {
    Context "User right assignment for SeCreateSymbolicLinkPrivilege" {
        It "Should match expected accounts depending on Hyper-V role installation" {

            # Determine expected accounts
            $expectedAccounts = @('BUILTIN\Administrators')

            if ($script:hyperVInstalled) {
                $expectedAccounts += 'NT VIRTUAL MACHINE\Virtual Machines'
            }

            Test-PrivilegeAssignments `
                -SidString $script:sidString `
                -ExpectedAccounts $expectedAccounts
        }
    }
}
