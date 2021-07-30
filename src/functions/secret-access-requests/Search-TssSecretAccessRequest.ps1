function Search-TssSecretAccessRequest {
    <#
    .SYNOPSIS
    Search Access Request for Secrets by status for current user.

    .DESCRIPTION
    Search Access Request for Secrets by status for current user.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Search-TssAccessRequest.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssAccessRequest -TssSession $session -IsMyRequest

    Return all Access Requests that the connected user submitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssAccessRequest -TssSession $session -Status Pending

    Return all pending Access Requests where connected user is submitter or an approver

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.AccessRequests.Request')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Status of the request
        [Parameter(Mandatory, Position = 1)]
        [ValidateSet('WaitingForRequest','Pending','Approved','Denied','Canceled','Expired')]
        [string]
        $Status,

        # Is request submitted by connecting user
        [switch]
        $IsMyRequest,

        # Sort by specific property, default SecretId
        [string]
        $SortBy = 'SecretId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-access-requests' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'IsMyRequest' { $filters += "filter.IsMyRequest=$([boolean]$IsMyRequest)" }
                'Status' { $filters += "filter.status=$Status" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No AccessRequest found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.AccessRequests.Request[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}