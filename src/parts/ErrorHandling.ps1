param(
    [Parameter(Mandatory,Position = 0)]
    [System.Management.Automation.ErrorRecord]
    $ErrorRecord
)
process {
    $errDetail = $ErrorRecord.ErrorDetails
    if ($errDetail) {
        if ($PSEdition -eq 'Core') {
            if (Test-Json $errDetail.Message -ErrorAction SilentlyContinue) {
                $errMessage = ConvertFrom-Json -InputObject $errDetail.Message
            } else {
                $errMessage = $errDetail.Message
            }
        } else {
            if ($errDetail.Message -match '{') {
                $errMessage = ConvertFrom-Json -InputObject $errDetail.Message
            } else {
                $errMessage = $errDetail.Message
            }
        }
        Write-Error "$($ErrorRecord.Exception.Message) | $($errMessage)"
    } elseif ($ErrorRecord -like '*<html*') {
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Response was HTML, Request Failed."),"ResultWasHTML", "NotSpecified", $invokeParams.Uri))
    } else {
        Write-Error $ErrorRecord.Exception
    }
}