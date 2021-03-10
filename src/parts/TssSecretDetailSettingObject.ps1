<#
    .Synopsis
        Creates a TssSecretDetailSettings object
#>
param(
    [pscustomobject]
    $Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}
process {
    $outObject = @()
    foreach ($p in $Object) {
        $currentObject = [TssSecretDetailSettings]::new()
        foreach ($pProp In $Properties) {
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                if ($p.$pProp) {
                    $currentObject.$pProp = $p.$pProp
                }
            } else {
                Write-Warning "Property $pProp does not exist in the TssSecretDetailSettings at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}