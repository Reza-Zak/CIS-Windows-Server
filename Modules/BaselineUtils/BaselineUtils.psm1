# ------------------------------------------------------------------------------------------------
# BaselineUtils.psm1
# Dynamic loader for all Public and Private functions.
# Exports ONLY Public functions for clean encapsulation.
# Version: 1.4.0
# ------------------------------------------------------------------------------------------------

# Locate function folders
$publicFolder  = Join-Path $PSScriptRoot 'Public'
$privateFolder = Join-Path $PSScriptRoot 'Private'

# ------------------------------------------------------------------------------------------------
# Load Public Functions
# ------------------------------------------------------------------------------------------------
Get-ChildItem -Path $publicFolder -Filter *.ps1 -ErrorAction Stop |
    ForEach-Object { . $_.FullName }

# ------------------------------------------------------------------------------------------------
# Load Private Functions
# ------------------------------------------------------------------------------------------------
Get-ChildItem -Path $privateFolder -Filter *.ps1 -ErrorAction Stop |
    ForEach-Object { . $_.FullName }

# ------------------------------------------------------------------------------------------------
# Extract Public Function Names
# Reads each Public function file and finds the declared function name
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
# Export Only Public Functions
# ------------------------------------------------------------------------------------------------
Export-ModuleMember -Function $publicFunctions
