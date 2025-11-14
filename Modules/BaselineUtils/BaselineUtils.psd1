@{
    # Script module file associated with this manifest
    RootModule        = 'BaselineUtils.psm1'

    # Module version
    ModuleVersion     = '1.4.0'

    # Unique identifier
    GUID              = 'b1234567-89ab-cdef-0123-456789abcdef'

    # Author / Company
    Author            = 'RBB'
    CompanyName       = 'RBB'

    # Copyright
    Copyright         = '(c) 2025 RBB. All rights reserved.'

    # Detailed description
    Description       = @'
BaselineUtils PowerShell module.
Provides helper functions for CIS Benchmark automation on Windows Server.
Includes: export/parse security policy, test privilege assignments,
account settings, and administrative rights validation.
'@

    # Minimum required PowerShell version
    PowerShellVersion = '5.1'

    # Export all functions, but module will respect Public/Private in PSM1
    FunctionsToExport = '*'
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    # Private metadata
    PrivateData = @{
        PSData = @{
            Tags         = @('CIS','Pester','WindowsServer','Security','BaselineUtils')
            LicenseUri   = 'https://opensource.org/licenses/MIT'
            ProjectUri   = 'https://github.com/RBB/BaselineUtils'
            ReleaseNotes = @'
Version 1.4.0:
- Full refactor to Public/Private folder layout
- Added Test-AdministratorRights, New-TestDataDirectory, Remove-TestDataDirectory
- Added Convert-SIDToName and Get-PrivilegeAssignmentsForCheck
- PSM1 now dynamically loads and exports Public functions
'@
        }
    }
}
