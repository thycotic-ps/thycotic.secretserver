<#
    .Synopsis
        Creates a TssSecretTemplate class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssSecretTemplate class to output the SecretTemplateModel object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object.PSObject.Properties.Where( { $_.Name -notin 'responseCodes' }).Name
}

process {
    foreach ($s in $Object) {
        $outObject = [TssSecretTemplate]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -in $outObject.PSObject.Properties.Name) {
                $outObject.$sProp = $s.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssSecretTemplate class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
    }
    return $outObject
}