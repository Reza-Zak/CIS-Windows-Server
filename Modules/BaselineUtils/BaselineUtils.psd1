@{
    # Script module or binary module file associated with this manifest.
    RootModule        = 'BaselineUtils.psm1'

    # Version number of this module.
    ModuleVersion     = '1.3.2'

    # Unique identifier for this module
    GUID              = 'b1234567-89ab-cdef-0123-456789abcdef'

    # Author of this module
    Author            = 'RBB'

    # Company or vendor of this module
    CompanyName       = 'RBB'

    # Copyright statement for this module
    Copyright         = '(c) 2025 RBB. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Utility functions for CIS Benchmark Pester tests on Windows Server 2022. 
                         Provides helper commands to export, parse, and test system security policies 
                         and privilege assignments for CIS compliance automation.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Functions to export from this module
    FunctionsToExport = @(
        'Test-AdministratorRights',
        'Export-SecurityPolicy',
        'Get-SecurityPolicy',
        'Get-PrivilegeAssignments',
        'Test-PrivilegeAssignments',
        'Get-SecurityOptionValue'
    )

    # Cmdlets to export from this module
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport   = @()

    # Private data to pass to the module specified in RootModule
    PrivateData = @{
        PSData = @{
            Tags         = @('CIS','Pester','WindowsServer2022','Security','BaselineUtils')
            LicenseUri   = 'https://opensource.org/licenses/MIT'
            ProjectUri   = 'https://github.com/YourOrg/CIS-Windows2022'
            ReleaseNotes = 'Refactored function names for PowerShell verb consistency; 
                            split module into Public/Private structure; 
                            version 1.3.1.'
        }
    }
}
