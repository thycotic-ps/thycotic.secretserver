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
    $uri = $TssSession.ApiUrl, 'folder-details', $Id -join '/'
    $uri = $uri, 'returnEmptyInsteadOfNoAccessException=true' -join '?'

    $invokeParams.Uri = $uri
    $invokeParams.Method = 'GET'

    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue getting folder details on folder [$folder]"
        $err = $_
        . $ErrorHandling $err
    }

    if ($restResponse) {
        [Thycotic.PowerShell.Folders.DetailView]$restResponse
    }
}