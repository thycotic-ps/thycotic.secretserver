function Search-TssDiscoveryAccountRule {
    <#
    .SYNOPSIS
    Search Discovery account rules

    .DESCRIPTION
    Returns Discovery account rules in their evaluation order. Active rules only unless Status is set.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Only include rules that apply to this discovery source

    .PARAMETER Status
    Rule status to include: All, Active or Inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryAccountRule -TssSession $session

    Get the active Discovery account rules

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryAccountRule -TssSession $session -Status All -DiscoverySourceId 2

    Get every Discovery account rule for discovery source 2, active or not

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryAccountRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryAccountRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.AccountRuleSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoverySourceId,

        [ValidateSet('All', 'Active', 'Inactive')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'accounts' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'Status' {
                    $queryParams += "filter.statusFilter=$([uri]::EscapeDataString($Status))"
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
                Write-Warning 'Issue with Search-TssDiscoveryAccountRule request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.AccountRuleSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.AccountRuleSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
