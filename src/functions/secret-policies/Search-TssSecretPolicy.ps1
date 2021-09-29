function Search-TssSecretPolicy {
    <#
    .SYNOPSIS
    Search Secret Policies

    .DESCRIPTION
    Search Secret Policies

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Search-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Search-TssSecretPolicy.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretPolicy -TssSession $session -PolicyName 'heartbeat'

    Search for Secret Policies with names matching "heartbeat"

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy names (contains)
        [string]
        $PolicyName,

        # Include inactive policies in search results
        [switch]
        $IncludeInactive,

        # Sort by specific property, default SecretPolicyName
        [string]
        $SortBy = 'SecretPolicyName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-policy', 'search' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'PolicyName' { $filters += "filter.secretPolicyName=$PolicyName" }
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
                Write-Warning "No SecretPolicy found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretPolicies.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}