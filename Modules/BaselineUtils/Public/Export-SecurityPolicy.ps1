<#
.SYNOPSIS
    Exports the current Windows Security Policy to a text file.

.DESCRIPTION
    Uses the built-in Secedit tool to export the current system security
    configuration to the specified output file. This file is later parsed
    by Get-SecurityPolicy for compliance validation.

.PARAMETER OutputPath
    The full file path where the exported policy will be saved.

.EXAMPLE
    Export-SecurityPolicy -OutputPath "C:\Temp\secedit.cfg"
#>
function Export-SecurityPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$OutputPath
    )

    secedit /export /cfg $OutputPath /quiet | Out-Null
}

