<#
    .Synopsis
        Creates a TssFolderSummary class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssFolderSummary class to output the FolderSummary object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($f in $Object) {
        $currentObject = [TssFolderSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$sProp = $f.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssFolderSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}