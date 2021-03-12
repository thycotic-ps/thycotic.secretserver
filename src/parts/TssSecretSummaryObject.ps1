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
    $Properties = $Object[0].PSObject.Properties.Where( { $_.Name -notin 'responseCodes' }).Name
}

process {
    $outSearch = @()
    foreach ($s in $Object) {
        $outObject = [TssSecretSummary]::new()
        foreach ($sProp in $Properties) {
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