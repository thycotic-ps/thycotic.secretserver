param(
    [Parameter(Mandatory,Position = 0)]
    [System.Management.Automation.ErrorRecord]
    $ErrorRecord
)
process {
    if ($ErrorRecord -like '*<html*') {
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Response was HTML, Request Failed."),"ResultWasHTML", "NotSpecified", $invokeParams.Uri))
    } else {
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("$ErrorRecord"),"ResultError", "NotSpecified", $invokeParams.Uri))
    }
}