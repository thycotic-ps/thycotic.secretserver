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
                $field.$fProp = $f.$fProp
                $fields += $field
            }
        }

        foreach ($s in $Object) {
            $outObject = [TssSecretTemplate]::new()
                foreach ($sProp in $Properties) {
                    if ($sProp -eq 'fields') {
                        $outObject.Fields = $fields
                    }
                    $outObject.$sProp = $s.$sProp
                }
        }
        return $outObject
}