<#
.SYNOPSIS
    Reads and parses an exported Windows Security Policy file.

.DESCRIPTION
    Imports a Secedit-exported configuration file (secedit.cfg) and
    converts it into a PowerShell hashtable for easier access during
    CIS benchmark evaluations.

.PARAMETER FilePath
    The path to the exported security policy file.

.EXAMPLE
    $policy = Get-SecurityPolicy -FilePath "C:\Temp\secedit.cfg"
#>
function Get-SecurityPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$FilePath
    )

    if (-not (Test-Path $FilePath)) {
        throw "Security policy file not found: $FilePath"
    }

    $policy = @{}
    foreach ($line in Get-Content $FilePath) {
        if ($line -match '^(?<Key>[^=]+)=(?<Value>.*)$') {
            $policy[$matches['Key'].Trim()] = $matches['Value'].Trim()
        }
    }
    return $policy
}
