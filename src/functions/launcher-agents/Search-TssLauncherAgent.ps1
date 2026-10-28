function Search-TssLauncherAgent {
    <#
    .SYNOPSIS
    Search launcher agents

    .DESCRIPTION
    Search Advanced Session Recording launcher agents.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeInactive
    Include inactive agents

    .PARAMETER LauncherAgentCollectionId
    Return only agents in this launcher agent collection

    .PARAMETER OutOfDate
    Return only out-of-date agents. Without it, or with -OutOfDate:$false, agents of every version are returned

    .PARAMETER SearchText
    Text to match against the agent host name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLauncherAgent -TssSession $session -OutOfDate

    Get the agents older than the minimum recommended version

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgent

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgent.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeInactive,

        [int]
        $LauncherAgentCollectionId,

        [switch]
        $OutOfDate,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'launcheragents' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                }
                'LauncherAgentCollectionId' {
                    $queryParams += "filter.launcherAgentCollectionId=$($LauncherAgentCollectionId)"
                }
                'OutOfDate' {
                    $queryParams += "filter.outOfDate=$([boolean]$OutOfDate)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
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
                Write-Warning 'Issue with Search-TssLauncherAgent request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.LauncherAgents.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.LauncherAgents.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
