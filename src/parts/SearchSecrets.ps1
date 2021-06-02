[cmdletbinding()]
param(
    [Parameter(Mandatory,Position = 0)]
    [TssSession]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    [int]
    $FolderId,

    [Parameter(Mandatory,Position = 2)]
    [string]
    $SearchText
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}
process {
    . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
    $uri = $TssSession.ApiUrl, 'secrets' -join '/'
    $uri += "?take=$($TssSession.Take)"
    $uri += "&filter.includeRestricted=true&filter.isExactmatch=true"

    $filters = @()
    $filters += "filter.searchText=$SearchText"
    $filters += "filter.folderId=$FolderId"

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
        [TssSecretSummary[]]$secret
    }
}