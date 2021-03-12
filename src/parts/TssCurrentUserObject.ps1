<#
    .Synopsis
        Creates a TssCurrentUser object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}
process {
    $outObject = @()
    foreach ($p in $Object) {
        $currentObject = [TssCurrentUser]::new()
        foreach ($pProp in $Properties) {
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$pProp = $p.$pProp
            } else {
                Write-Warning "Property $pProp does not exist in the TssCurrentUser class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}