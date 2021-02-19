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
    $Properties = $Object.PSObject.Properties.Where({$_.Name -notin 'responseCodes'}).Name
    $fieldProperties = $Object.fields[0].PSObject.Properties.Name
}

process {
    $fields = @()
        foreach ($f in $Object.fields) {
            $field = [TssSecretTemplateField]::new()
            foreach ($fProp in $fieldProperties) {
                if ($fProp -in $field.PSObject.Properties.Name) {
                    $field.$fProp = $f.$fProp
                } else {
                    Write-Warning "Property $fProp does not exist in the TssSecretTempalteField class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $fields += $field
            }
        }

        foreach ($s in $Object) {
            $outObject = [TssSecretTemplate]::new()
                foreach ($sProp in $Properties) {
                    if ($sProp -eq 'fields') {
                        $outObject.Fields = $fields
                    }
                    if ($sProp -in $outObject.PSObject.Properties.Name) {
                        $outObject.$sProp = $s.$sProp
                    } else {
                        Write-Warning "Property $sProp does not exist in the TssSecretTempalte class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                    }
                }
        }
        return $outObject
}