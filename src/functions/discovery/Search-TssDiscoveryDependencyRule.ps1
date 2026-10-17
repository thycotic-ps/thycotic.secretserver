function Search-TssDiscoveryDependencyRule {
    <#
    .SYNOPSIS
    Search Discovery dependency rules

    .DESCRIPTION
    Returns the Discovery dependency rules in sort order. Removed rules stay listed as inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Return only rules of this discovery source

    .PARAMETER StatusFilter
    Active returns active rules (the server default). Inactive and All both return every rule, active and inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyRule -TssSession $session

    List the active dependency rules

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyRule -TssSession $session -DiscoverySourceId 1 -StatusFilter All

    List every dependency rule of discovery source 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyRuleSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoverySourceId,

        [ValidateSet('Active', 'Inactive', 'All')]
        [string]
        $StatusFilter
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'StatusFilter' {
                    $queryParams += "filter.statusFilter=$([uri]::EscapeDataString($StatusFilter))"
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
                Write-Warning 'Issue with Search-TssDiscoveryDependencyRule request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.DependencyRuleSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.DependencyRuleSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
