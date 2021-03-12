<#
    .Synopsis
        Creates a TssUserRoleSummary object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($r in $Object) {
        $currentObject = [TssUserRoleSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$sProp = $r.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssUserRoleSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}