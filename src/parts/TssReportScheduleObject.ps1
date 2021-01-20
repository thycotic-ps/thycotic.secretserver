<#
    .Synopsis
        Creates a TssReportSchedule class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssReportSchedule class to output the ReportScheduleSummaryModel object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    foreach ($s in $Object) {
        $outReportSched = [TssReportSchedule]::new()
        foreach ($rsProp in $Properties) {
            if ($rsProp -in $outReportSched.PSObject.Properties.Name) {
                if ($s.$rsProp) {
                    $outReportSched.$rsProp = $s.$rsProp
                }
            } else {
                Write-Warning "Property $rsProp does not exist in the TssReportSchedule class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
    }
    return $outReportSched
}