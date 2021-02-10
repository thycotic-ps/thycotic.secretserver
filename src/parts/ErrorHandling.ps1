param(
    [Parameter(Mandatory,Position = 0)]
    [System.Management.Automation.ErrorRecord]
    $ErrorRecord
)
process {
    $errDetailMsg = $ErrorRecord.ErrorDetails.Message
    if ($errDetailMsg.Length -gt 0) {
        throw $errDetailMsg
    } elseif ($ErrorRecord -like '*<html*') {
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Response was HTML, Request Failed."),"ResultWasHTML", "NotSpecified", $invokeParams.Uri))
    } else {
        throw $ErrorRecord.Exception
    }
}