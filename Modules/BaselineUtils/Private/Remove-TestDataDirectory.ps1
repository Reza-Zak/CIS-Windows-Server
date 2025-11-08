<#
.SYNOPSIS
    Removes a temporary test data directory and its contents.

.DESCRIPTION
    Deletes all files and subdirectories under the specified path
    to clean up after CIS benchmark tests.

.PARAMETER Path
    Path to the test data directory to remove.

.EXAMPLE
    Remove-TestDataDirectory -Path $dir
#>
function Remove-TestDataDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (Test-Path $Path) {
        Remove-Item -Path $Path -Recurse -Force
    }
}
