<#
    .Synopsis
        Creates a TssSecretSummary class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssSecretSummary class to output the SecretSummary object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Where({$_.Name -notin 'responseCodes'}).Name
    try {
        $extFieldProperties = $Object.extendedFields[0].PSObject.Properties.Name
    } catch {
        Write-Verbose "No extended fields objects found"
    }
}

process {
    $extFields = @()
    foreach ($ef in $Object.extendedFields) {
        $item = [TssSecretSummaryExtendedField]::new()
        foreach ($iProp in $extFieldProperties) {
            if ($iProp -in $item.PSObject.Properties.Name) {
                $item.$iProp = $ef.$iProp
            } else {
                Write-Warning "Property $iProp does not exist in the TssSecretSummaryExtendedField class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
            $extFields += $item
        }
    }
    $outSearch = @()
    foreach ($s in $Object) {
        $outObject = [TssSecretSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -eq 'extendedFields') {
                $outObject.ExtendedFields = $extFields
            }
            if ($sProp -in $outObject.PSObject.Properties.Name) {
                if ($s.$sProp) {
                    $outObject.$sProp = $s.$sProp
                }
            } else {
                Write-Warning "Property $sProp does nto exist in the TssSecretSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outSearch += $outObject
    }
    return $outSearch
}