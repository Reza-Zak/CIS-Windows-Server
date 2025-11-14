# ------------------------------------------------------------------------------------------------
# BaselineUtils.psm1
# Dynamic module loader for BaselineUtils PowerShell module
# Loads Public & Private functions and exports only Public functions
# ------------------------------------------------------------------------------------------------

# Define folder locations
$publicFolder  = Join-Path $PSScriptRoot 'Public'
$privateFolder = Join-Path $PSScriptRoot 'Private'

# ------------------------------------------------------------------------------------------------
# Load Public Functions (Dot-Source)
# ------------------------------------------------------------------------------------------------
Get-ChildItem -Path $publicFolder -Filter *.ps1 -ErrorAction Stop |
    ForEach-Object { . $_.FullName }

# ------------------------------------------------------------------------------------------------
# Load Private Functions (Dot-Source)
# ------------------------------------------------------------------------------------------------
Get-ChildItem -Path $privateFolder -Filter *.ps1 -ErrorAction Stop |
    ForEach-Object { . $_.FullName }

# ------------------------------------------------------------------------------------------------
# Extract Public Function Names for Export
# We read the function names from each Public function file
# ------------------------------------------------------------------------------------------------
$publicFunctions =
    Get-ChildItem -Path $publicFolder -Filter *.ps1 |
    ForEach-Object {
        $funcLine = Select-String -Path $_.FullName -Pattern 'function\s+([A-Za-z0-9-]+)' -SimpleMatch
        if ($funcLine) {
            [regex]::Match($funcLine.Line, 'function\s+([A-Za-z0-9-]+)').Groups[1].Value
        }
    }

# ------------------------------------------------------------------------------------------------
# Export only Public functions
# ------------------------------------------------------------------------------------------------
Export-ModuleMember -Function $publicFunctions
