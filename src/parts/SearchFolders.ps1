<#
    .SYNOPSIS
    Search secret folders
    #>
[CmdletBinding()]
param (
    # TssSession object created by New-TssSession for auth
    [Parameter(Mandatory,Position = 0)]
    [TssSession]
    $TssSession,

    # Search by text value
    [Parameter(Mandatory,Position = 1)]
    [string]
    $SearchText
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}

process {
    $restResponse = $null
    $uri = $TssSession.ApiUrl, 'folders' -join '/'
    $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=FolderPath&take=$($TssSession.Take)&filter.folderTypeId=1&filter.searchText=$SearchText" -join '?'

    $invokeParams.Uri = $uri
    $invokeParams.Method = 'GET'

    Write-Verbose "$($invokeParams.Method) $uri with $body"
    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue on search request"
        $err = $_
        . $ErrorHandling $err
    }

    if ($restResponse.records) {
        [TssFolderSummary[]]$restResponse.records
    }
}