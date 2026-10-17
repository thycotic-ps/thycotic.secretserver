function Search-TssLauncherAgentIssue {
    <#
    .SYNOPSIS
    Search launcher agents that have issues

    .DESCRIPTION
    Search Advanced Session Recording launcher agents that report an issue. The Issue property says what is wrong.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherAgentCollectionId
    Return only agents in this launcher agent collection

    .PARAMETER SearchText
    Text to match against the agent host name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLauncherAgentIssue -TssSession $session | Select-Object HostName, Issue

    List the agents with issues and what each issue is

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgentIssue

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgentIssue.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $LauncherAgentCollectionId,

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
            $uri = $TssSession.ApiUrl, 'launcheragents', 'issues' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'LauncherAgentCollectionId' {
                    $queryParams += "filter.launcherAgentCollectionId=$($LauncherAgentCollectionId)"
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
                Write-Warning 'Issue with Search-TssLauncherAgentIssue request'
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
