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
    $secretProperties = $SecretRecord.PSObject.Properties.Where({$_.Name -notin 'responseCodes'}).Name
    $itemProperties = $SecretRecord.items[0].PSObject.Properties.Name
}

process {
    $items = @()
    foreach ($i in $SecretRecord.items) {
        $item = [TssSecretItem]::new()
        foreach ($iProp in $itemProperties) {
            $item.$iProp = $i.$iProp
        }
        $items += $item
    }

    foreach ($s in $SecretRecord) {
        $outSecret = [TssSecret]::new()
        foreach ($sProp in $secretProperties) {
            if ($sProp -eq 'items') {
                $outSecret.Items = $items
            }
            $outSecret.$sProp = $s.$sProp
        }
    }
    return $outSecret
}