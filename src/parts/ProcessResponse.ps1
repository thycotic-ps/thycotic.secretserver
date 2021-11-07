[cmdletbinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [RestSharp.RestResponse]
    $Response
)
$requestStatus = [Thycotic.PowerShell.Common.RequestStatus]@{
    StatusCode        = [int]$Response.StatusCode
    StatusDescription = $Response.StatusDescription
    IsSuccessful      = $Response.IsSuccessful
    ResponseStatus    = $Response.ResponseStatus
    ResponseUri       = $Response.ResponseUri
}
New-Variable -Name tssLastResponse -Value $requestStatus -Description "Contains request status object for the command's last web request" -Visibility Public -Scope Global -Force -WhatIf:$false
if (-not $Response.IsSuccessful -or ($Response.StatusCode -ne 200)) {
    if ($Response.ErrorException -is [System.Net.WebException]) {
        $exc = [Exception]::new($Response.ErrorException)
        $err = [System.Management.Automation.ErrorRecord]::new(
            $exc,
            $Response.ErrorException.HResult,
            [System.Management.Automation.ErrorCategory]::ConnectionError,
            $invokeParams.Uri
        )
        $PSCmdlet.ThrowTerminatingError($err)
    } elseif ($Response.StatusCode -eq 500) {
        $exc = [Exception]::new($Response.StatusDescription)
        $err = [System.Management.Automation.ErrorRecord]::new(
            $exc,
            $Response.StatusCode,
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Response.ResponseUri
        )
        $PSCmdlet.ThrowTerminatingError($err)
    } else {
        $errorContent = $Response.Content
        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new($errorContent),"ResultError", "NotSpecified", $invokeParams.Uri))
    }
} else {
    if ($Response.Content.StartsWith("{") -and $Response.Content.EndsWith("}")) {
        $content = $Response.Content | ConvertFrom-Json
    } elseif ($Response.Content.StartsWith("[") -and $Response.Content.EndsWith("]")) {
        $content = $Response.Content | ConvertFrom-Json
    } else {
        if ($Response.ContentType -ne 'application/octet-stream') {
            $content = $Response.Content
        }
        if ($Response.Content -is [System.String]) {
            $content = $Response.Content
        }
    }
    return $content
}