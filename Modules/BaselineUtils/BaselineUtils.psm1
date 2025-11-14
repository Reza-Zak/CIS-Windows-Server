# -------------------------------------------------------------------
# BaselineUtils PowerShell Module
# Auto-loads Public and Private functions dynamically
# -------------------------------------------------------------------

# Define folder paths
$public  = Join-Path $PSScriptRoot 'Public'
$private = Join-Path $PSScriptRoot 'Private'

# -------------------------------------------------------------------
# Load Public Functions
# -------------------------------------------------------------------
Get-ChildItem -Path $public -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

# -------------------------------------------------------------------
# Load Private Functions
# -------------------------------------------------------------------
Get-ChildItem -Path $private -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

# -------------------------------------------------------------------
# Extract Public Function Names for Export
# -------------------------------------------------------------------
$publicFunctionNames = Get-ChildItem -Path $public -Filter *.ps1 | ForEach-Object {

    # Extract the function name from inside the file
    $functionLine = Select-String -Path $_.FullName -Pattern 'function\s+([A-Za-z0-9-]+)' -SimpleMatch

    if ($functionLine) {
        $matches = [regex]::Match($functionLine.Line, 'function\s+([A-Za-z0-9-]+)')
        $matches.Groups[1].Value
    }
}

# -------------------------------------------------------------------
# Export only Public functions
# -------------------------------------------------------------------
Export-ModuleMember -Function $publicFunctionNames
