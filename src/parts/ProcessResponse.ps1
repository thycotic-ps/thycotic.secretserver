[cmdletbinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [RestSharp.RestResponse]
    $Response
)

if ($Response.Content.StartsWith("{") -and $Response.Content.EndsWith("}")) {
    $content = $Response.Content | ConvertFrom-Json
} elseif ($Response.Content.StartsWith("[") -and $Response.Content.EndsWith("]")) {
    $content = $Response.Content | ConvertFrom-Json
} else {
    $content = $Response.Content
}

$requestStatus = [Thycotic.PowerShell.Common.RequestStatus]@{
    StatusCode        = [int]$Response.StatusCode
    StatusDescription = $Response.StatusDescription
    IsSuccessful      = $Response.IsSuccessful
    ResponseStatus    = $Response.ResponseStatus
    ResponseUri       = $Response.ResponseUri
}
New-Variable -Name tssLastResponse -Value $requestStatus -Description "Contains request status object for the command's last web request" -Visibility Public -Scope Global -Force

if (-not $Response.IsSuccessful) {
    $errorContent = $Response.Content
    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new($errorContent),"ResultError", "NotSpecified", $invokeParams.Uri))
} else {
    return $content
}
