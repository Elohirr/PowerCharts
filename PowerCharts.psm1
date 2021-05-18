$root = Split-Path $MyInvocation.MyCommand.Path -Parent;

# Import-Module 



# Grab functions from files 
Resolve-Path $root\*.ps1 |
    Where-Object { -not ($_.ProviderPath.Contains(".Tests.")) } |
    ForEach-Object { . $_.ProviderPath; }

# $privateFiles = Get-Childitem -Path $root\private -Recurse -Include *.ps1 -ErrorAction SilentlyContinue
$publicFiles = Get-Childitem -Path $root -Recurse -Include *.ps1 -ErrorAction SilentlyContinue

# if (@($privateFiles).Count -gt 0) { $privateFiles.FullName | ForEach-Object { . $_; } }
if (@($publicFiles).Count -gt 0) { $publicFiles.FullName | ForEach-Object { . $_; } }

$publicFuncs = $publicFiles | ForEach-Object { $_.Name.Substring(0, $_.Name.Length - 4) }
Export-ModuleMember -Function $publicFuncs

# Global Variables
if ($Null -eq $global:EloCharts) {

    $global:EloCharts = @{}

}
