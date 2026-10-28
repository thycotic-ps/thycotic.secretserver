function Search-TssDomainIndex {
    <#
    .SYNOPSIS
    Search the domain name index

    .DESCRIPTION
    Search the Discovery domain name index: each entry shows the domain name, how it resolved, the discovery source it maps to, whether it is ignored, and when it was indexed and expires.
    The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceIdScanned
    Only entries found by this discovery source

    .PARAMETER DomainName
    Text to match in the domain name

    .PARAMETER DomainResolveType
    Only entries resolved this way

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDomainIndex -TssSession $session -DomainResolveType CouldNotResolve

    List the domains Discovery could not resolve

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDomainIndex -TssSession $session -DomainName example.com

    Find index entries for example.com

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Search-TssDomainIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Search-TssDomainIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DomainIndex.DomainNameIndex[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoverySourceIdScanned,

        [string]
        $DomainName,

        [ValidateSet('CouldNotResolve', 'MatchedDomainInDb', 'MatchedFQDNOrFriendlyOrNetBIOSInDb', 'MatchedFriendlyNameWithAd', 'ManualUserInputDiscoverySourceId')]
        [string]
        $DomainResolveType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'domain-index' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoverySourceIdScanned' {
                    $queryParams += "filter.discoverySourceIdScanned=$($DiscoverySourceIdScanned)"
                }
                'DomainName' {
                    $queryParams += "filter.domainName=$([uri]::EscapeDataString($DomainName))"
                }
                'DomainResolveType' {
                    $queryParams += "filter.domainResolveType=$([uri]::EscapeDataString($DomainResolveType))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDomainIndex request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DomainIndex.DomainNameIndex[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DomainIndex.DomainNameIndex]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
