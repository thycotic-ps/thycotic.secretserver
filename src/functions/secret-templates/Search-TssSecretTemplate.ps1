function Search-TssSecretTemplate {
    <#
    .SYNOPSIS
    Search for Secret Templates

    .DESCRIPTION
    Search for Secret Templates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplate -TssSession $session -SearchText key

    Return all Secret Templates where "key" is in the template name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Search text for Template Name
        [string]
        $SearchText,

        # Include Secret Count
        [switch]
        $IncludeSecretCount,

        # Include inactive Secret Templates
        [switch]
        $IncludeInactive,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'name'
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
            $uri = $TssSession.ApiUrl, 'secret-templates' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('SearchText')) {
                $filters += "filter.searchText=$SearchText"
            }
            if ($tssParams.ContainsKey('IncludeSecretCount')) {
                $filters += "filter.includeSecretCount=$IncludeSecretCount"
            }
            if ($tssParams.ContainsKey('IncludeInactive')) {
                $filters += "filter.includeInactive=$IncludeInactive"
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No Secret Templates found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplates.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}