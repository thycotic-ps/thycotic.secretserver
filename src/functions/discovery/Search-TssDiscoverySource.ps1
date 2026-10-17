function Search-TssDiscoverySource {
    <#
    .SYNOPSIS
    Search discovery sources

    .DESCRIPTION
    Lists discovery sources.
    Returns active sources unless -IncludeInactive is given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceName
    Only return sources whose name contains this text

    .PARAMETER DiscoverySourceType
    Only return sources of this type, for example ActiveDirectory or Unix

    .PARAMETER IncludeActive
    Include active sources

    .PARAMETER IncludeInactive
    Include inactive sources

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoverySource -TssSession $session

    List the active discovery sources

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoverySource -TssSession $session -IncludeInactive

    List active and inactive discovery sources

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.SourceSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $DiscoverySourceName,

        [string]
        $DiscoverySourceType,

        [switch]
        $IncludeActive,

        [switch]
        $IncludeInactive
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'sources' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoverySourceName' {
                    $queryParams += "filter.discoverySourceName=$([uri]::EscapeDataString($DiscoverySourceName))"
                }
                'DiscoverySourceType' {
                    $queryParams += "filter.discoverySourceType=$([uri]::EscapeDataString($DiscoverySourceType))"
                }
                'IncludeActive' {
                    $queryParams += "filter.includeActive=$([boolean]$IncludeActive)"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
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
                Write-Warning 'Issue with Search-TssDiscoverySource request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.SourceSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.SourceSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
