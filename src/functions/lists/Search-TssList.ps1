function Search-TssList {
    <#
    .SYNOPSIS
    Search Lists

    .DESCRIPTION
    Search Lists

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Search-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Search-TssList.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssList -TssSession $session -SearchText dev

    Return all Lists that have "dev" in their name

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Search text
        [string]
        $SearchText,

        # Include inactive
        [switch]
        $IncludeInactive,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'lists' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            $filters += "filter.includeActive=true"
            switch ($tssParams.Keys) {
                'SearchText' { $filters += "filter.SearchText=$SearchText" }
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No records found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Lists.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}