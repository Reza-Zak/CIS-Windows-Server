<#
.SYNOPSIS
    Retrieves user right assignments for a specific privilege name.
.DESCRIPTION
    Exports the current security policy to a temporary location, 
    retrieves user right assignments for the specified privilege,
    and then cleans up automatically.
.PARAMETER PrivilegeName
    The privilege name (e.g. 'SeBackupPrivilege', 'SeInteractiveLogonRight').
.EXAMPLE
    Get-PrivilegeAssignmentsForCheck -PrivilegeName 'SeBackupPrivilege'
.NOTES
    Author: RBA
    Version: 1.3.2
#>
function Get-PrivilegeAssignmentsForCheck {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$PrivilegeName
    )

    $tempDir = New-TestDataDirectory
    try {
        $seceditFile = Join-Path $tempDir 'secedit.inf'
        Export-SecurityPolicy -OutputPath $seceditFile
        $sidData = Get-PrivilegeAssignments -FilePath $seceditFile -PrivilegeName $PrivilegeName
        return $sidData
    }
    finally {
        Remove-TestDataDirectory -Path $tempDir
    }
}
