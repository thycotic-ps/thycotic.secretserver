[cmdletbinding()]
param(
    [Parameter(Mandatory,Position = 0)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    [int]
    $Id
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}
process {
    $restResponse = $null
    $uri = $TssSession.ApiUrl, 'secrets', $Id, 'state' -join '/'
    $invokeParams.Uri = $uri
    $invokeParams.Method = 'GET'

    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue getting details on secret [$Id]"
    }

    if ($restResponse) {
        [Thycotic.PowerShell.Secrets.DetailState]$restResponse
    }
}