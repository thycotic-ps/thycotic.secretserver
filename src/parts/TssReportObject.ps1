<#
    .Synopsis
        Creates a TssReport class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssReport class to output the ReportModel object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object.PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($r in $Object) {
        $outReportObject = [TssReport]::new()
        foreach ($rProp in $Properties) {
            if ($rProp -in $outReportObject.PSObject.Properties.Name) {
                $outReportObject.$rProp = $r.$rProp
            } else {
                Write-Warning "Property $rProp does not exist in the TssReport class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $outReportObject
    }
    return $outObject
}