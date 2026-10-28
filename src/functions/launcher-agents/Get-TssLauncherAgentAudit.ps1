function Get-TssLauncherAgentAudit {
    <#
    .SYNOPSIS
    Get launcher agent audits

    .DESCRIPTION
    Get the audit records of every launcher agent, or of the launcher agents in one launcher agent collection with -LauncherAgentCollectionId. Secret Server keys this route by collection Id, not by agent Id.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherAgentCollectionId
    Launcher agent collection Id. Returns the audit records of the launcher agents in that collection. Binds from the pipeline by LauncherAgentCollectionId, CollectionId (launcher agent output) or Id (launcher agent collection output). Omit to get the audit records of every launcher agent

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgentAudit -TssSession $session

    Get the audit records of every launcher agent

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgentAudit -TssSession $session -LauncherAgentCollectionId 3

    Get the audit records of the launcher agents in launcher agent collection 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgent -TssSession $session -Id 23 | Get-TssLauncherAgentAudit -TssSession $session | Where-Object LauncherAgentId -eq 23

    Get the audit records of launcher agent 23: the pipeline binds the agent's CollectionId, then the filter keeps that agent's rows

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'collection')]
        [Alias('CollectionId', 'Id')]
        [int[]]
        $LauncherAgentCollectionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uris = [System.Collections.Generic.List[string]]::new()
            if ($PSCmdlet.ParameterSetName -eq 'collection') {
                foreach ($currentId in $LauncherAgentCollectionId) {
                    $uri = $TssSession.ApiUrl, 'launcheragents', $currentId, 'audit' -join '/'
                    $uris.Add($uri)
                }
            } else {
                $uri = $TssSession.ApiUrl, 'launcheragents', 'audit' -join '/'
                $uris.Add($uri)
            }
            foreach ($currentUri in $uris) {
                $restResponse = $null
                $invokeParams.Uri = $currentUri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $currentUri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssLauncherAgentAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.LauncherAgents.Audit[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
