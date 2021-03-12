<#
.Synopsis
    Creates a TssSecret object to output the SecretModel object
.Description
    Creates an instance of the TssSecret class to output the SecretModule object
#>
param(
    [pscustomobject]$SecretRecord
)

begin {
    $secretProperties = $SecretRecord.PSObject.Properties.Where( { $_.Name -notin 'responseCodes' }).Name
}

process {
    foreach ($s in $SecretRecord) {
        $outSecret = [TssSecret]::new()
        foreach ($sProp in $secretProperties) {
            if ($sProp -in $outSecret.PSObject.Properties.Name) {
                $outSecret.$sProp = $s.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssSecret class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
    }
    return $outSecret
}