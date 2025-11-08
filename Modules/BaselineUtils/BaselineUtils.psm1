# Load Public and Private functions dynamically
$public  = Join-Path $PSScriptRoot 'Public'
$private = Join-Path $PSScriptRoot 'Private'

# Dot-source all function files
Get-ChildItem -Path $public -Filter *.ps1 | ForEach-Object { . $_.FullName }
Get-ChildItem -Path $private -Filter *.ps1 | ForEach-Object { . $_.FullName }

# Export only Public functions
Export-ModuleMember -Function (Get-ChildItem -Path $public -Filter *.ps1 | ForEach-Object {
    (Get-Command -Path $_.FullName).Name
})

