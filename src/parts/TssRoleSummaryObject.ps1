<#
    .Synopsis
        Creates a TssRoleSummary object
#>
param(
    [pscustomobject]$Object,
    [int]$UserId
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($r in $Object) {
        $currentObject = [TssRoleSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$sProp = $r.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssRoleSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $currentObject.UserId = $UserId
        $outObject += $currentObject
    }
    return $outObject
}