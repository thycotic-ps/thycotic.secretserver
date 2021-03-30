<#
    .Synopsis
        Validates Version of Secret Server
    .Description
        Validates version of Secret Server
        Throws a message if detected version is lower than input (minimum)
#>
[cmdletbinding()]
param(
    [Parameter(Mandatory,Position = 0)]
    [TssSession]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    $MinimumSupported,

    [Parameter(Mandatory,Position = 2)]
    [System.Management.Automation.InvocationInfo]
    $Invocation
)

process {
    $source = $Invocation.MyCommand
    $uri = $TssSession.ApiUrl, 'version' -join '/'
    $invokeParams.Uri = $Uri
    $invokeParams.Method = 'GET'

    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue reading version, verify Hide Secret Server Version Numbers is disabled in Secret Server"
        $err = $_
        . $ErrorHandling $err
    }

    $currentVersion = $restResponse.model.version

    if ($currentVersion -lt $MinimumSupported) {
        Write-Warning "[$source] is only supported on [$MinimumSupported]+ of Secret Server. Secret Server host [$($TssSession.SecretServer)] version: [$currentVersion]"
    }
}