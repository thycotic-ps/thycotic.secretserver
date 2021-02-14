param(
    [Parameter(Mandatory,Position = 0)]
    [System.Management.Automation.ErrorRecord]
    $ErrorRecord
)
process {
    $errDetail = $ErrorRecord.ErrorDetails
    if ($errDetail) {
        $errMessage = ConvertFrom-Json -InputObject $errDetail.Message
        Write-Error "$($ErrorRecord.Exception.Message) | $($errMessage.Message)"
    } elseif ($ErrorRecord -like '*<html*') {
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Response was HTML, Request Failed."),"ResultWasHTML", "NotSpecified", $invokeParams.Uri))
    } else {
        Write-Error $ErrorRecord.Exception
    }
}