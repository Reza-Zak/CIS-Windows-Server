<#
.SYNOPSIS
    CIS Check: 1.1.6 - Relax Minimum Password Length Limits

.DESCRIPTION
    Validates that the system is configured to allow relaxed minimum password length limits (Enabled = 1).

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
}

Describe "CIS Check: 1.1.6 - Relax Minimum Password Length Limits" -Tag $script:testTags {
    Context "Registry setting for RelaxMinimumPasswordLengthLimits" {
        It "Should be set to Enabled (1)" {
            # Read registry value
            $regPath   = 'HKLM:\SYSTEM\CurrentControlSet\Control\SAM'
            $valueName = 'RelaxMinimumPasswordLengthLimits'

            $actualValue = (Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

            # Validate that the registry value is enabled (1)
            $actualValue | Should -Be 1
        }
    }
}
