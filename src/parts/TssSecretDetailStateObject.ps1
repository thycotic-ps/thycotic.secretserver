<#
    .Synopsis
        Creates a TssSecretDetailState object
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
        $currentObject = [TssSecretDetailState]::new()
        foreach ($pProp in $Properties) {
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$pProp = $p.$pProp
            } else {
                Write-Warning "Property $pProp does not exist in the TssSecretDetailState class.thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}