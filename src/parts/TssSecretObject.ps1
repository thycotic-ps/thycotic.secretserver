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
            if ($iProp -in $item.PSObject.Properties.Name) {
                $item.$iProp = $i.$iProp
            } else {
                Write-Warning "Property $sProp does not exists on the TssSecret class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $items += $item
    }

    foreach ($s in $SecretRecord) {
        $outSecret = [TssSecret]::new()
        foreach ($sProp in $secretProperties) {
            if ($sProp -eq 'items') {
                $outSecret.Items = $items
            }
            if ($sProp -in $outSecret.PSObject.Properties.Name) {
                $outSecret.$sProp = $s.$sProp
            } else {
                Write-warning "Property $sProp does not exist in the TssSecret class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
    }
    return $outSecret
}