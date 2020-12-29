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
            $item.$iProp = $ef.$iProp
            $extFields += $item
        }
    }

    foreach ($s in $Object) {
        $outObject = [TssSecretSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -eq 'extendedFields') {
                $outObject.ExtendedFields = $extFields
            }
            if ($s.$sProp) {
                $outObject.$sProp = $s.$sProp
            }
        }
    }
    return $outObject
}