<#
    .Synopsis
        Creates a TssGroupSummary class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssGroupSummary class to output the GroupSummary object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($g in $Object) {
        $outGroupSummary = [TssGroupSummary]::new()
        foreach ($rsProp in $Properties) {
            if ($rsProp -in $outGroupSummary.PSObject.Properties.Name) {
                $outGroupSummary.$rsProp = $g.$rsProp
            } else {
                Write-Warning "Property $rsProp does not exist in the TssGroupSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $outGroupSummary
    }
    return $outObject
}