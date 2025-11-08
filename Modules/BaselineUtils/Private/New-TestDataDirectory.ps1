<#
.SYNOPSIS
    Creates and returns a temporary directory for test data storage.

.DESCRIPTION
    Generates a uniquely named temporary folder under a given root path
    for storing exported configuration files and temporary data during tests.

.PARAMETER RootPath
    Root directory under which the test data folder is created.

.EXAMPLE
    $dir = New-TestDataDirectory -RootPath $PSScriptRoot
#>
function New-TestDataDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$RootPath
    )

    $testDir = Join-Path $RootPath "TestData_$(Get-Random)"
    New-Item -Path $testDir -ItemType Directory -Force | Out-Null
    return $testDir
}

