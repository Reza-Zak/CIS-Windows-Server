function Get-SecurityOptionValue {
    <#
    .SYNOPSIS
        Retrieves the value of a specific Security Option from secedit output.

    .DESCRIPTION
        Exports the Local Security Policy (if required) and retrieves a 
        specific option (e.g. 'EnableGuestAccount', 'LimitBlankPasswordUse').

    .PARAMETER OptionName
        The name of the security option key in the secedit export.

    .EXAMPLE
        Get-SecurityOptionValue -OptionName 'EnableGuestAccount'
    #>

    param(
        [Parameter(Mandatory)]
        [string]$OptionName
    )

    # Export security policy to temp TestData directory
    $testData = Initialize-TestDataDirectory -RootPath $PSScriptRoot
    $outputFile = Join-Path $testData "secedit.inf"

    Export-SecurityPolicy -OutputPath $outputFile

    # Parse the file
    $policy = @{}
    foreach ($line in Get-Content $outputFile) {
        if ($line -match "^([^=]+)=(.*)$") {
            $policy[$matches[1].Trim()] = $matches[2].Trim()
        }
    }

    # Retrieve requested option
    return $policy[$OptionName]
}
