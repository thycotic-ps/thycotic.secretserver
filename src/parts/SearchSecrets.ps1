[cmdletbinding()]
param(
    [Parameter(Mandatory,Position = 0)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession,

    [Parameter(Position = 1)]
    [int]
    $FolderId,

    [Parameter(Position = 2)]
    [string]
    $SearchText
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}
process {
    $uri = $TssSession.ApiUrl, 'secrets' -join '/'
    $uri += "?take=$($TssSession.Take)"
    $uri += "&filter.includeRestricted=true"

    $filters = @()
    if ($FolderId) {
        $filters += "filter.folderId=$FolderId"
    }
    if ($SearchText) {
        $filters += "filter.searchText=$SearchText"
        $filters += "filter.isExactmatch=true"
    }

    if ($filters) {
        $uriFilter = $filters -join '&'
        Write-Verbose "Filters: $uriFilter"
        $uri = $uri, $uriFilter -join '&'
    }

    $invokeParams.Uri = $uri

    $invokeParams.Method = 'GET'
    Write-Verbose "$($invokeParams.Method) $uri"
    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue on search request"
        $err = $_
        . $ErrorHandling $err
    }

    if ($restResponse.records) {
        [TssSecretSummary[]]$restResponse.records
    }
}