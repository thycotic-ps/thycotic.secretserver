function Search-RpcPasswordType {
    <#
    .SYNOPSIS
    List available Password Types

    .DESCRIPTION
    List available Password Types

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Search-TssRpcPasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Search-RpcPasswordType.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRpcPasswordType -TssSession $session -SearchTerm Directory -IncludeInactive

    List Password Types that are inactive and have "Directory" in the name

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssPasswordTypeSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Search based on text in Name
        [Alias('SearchTerm')]
        [string]
        $SearchText,

        # Include inactive objects
        [boolean]
        $IncludeInactive,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-types' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('SearchText')) {
                $filters += "filter.searchTerm=$SearchText"
            }
            if ($tssParams.ContainsKey('IncludeInactive')) {
                $filters += "filter.includeInactive=$([boolean]$IncludeInactive)"
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No RpcPasswordType found'
            }
            if ($restResponse.records) {
                [TssPasswordTypeSummary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}