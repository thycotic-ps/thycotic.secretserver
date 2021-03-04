<#
    .Synopsis
        Creates a TssSecretAudit object
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
        $currentObject = [TssSecretAudit]::new()
        foreach ($pProp in $Properties) {
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                if ($p.$pProp) {
                    $currentObject.$pProp = $p.$pProp
                }
            } else {
                Write-Warning "Property $pProp does not exist in the TssSecretAudit class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}