function Get-TssLauncherAgent {
    <#
    .SYNOPSIS
    Get a launcher agent

    .DESCRIPTION
    Get an Advanced Session Recording launcher agent by Id. An unknown Id returns nothing.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent Id

    .PARAMETER IncludeInactive
    Return the agent even when it is inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLauncherAgent -TssSession $session | Get-TssLauncherAgent -TssSession $session

    Get every active launcher agent

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgent

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgent.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.LauncherAgents.LauncherAgent')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'launcheragents', $currentId -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'IncludeInactive' {
                        $queryParams += "includeInactive=$([boolean]$IncludeInactive)"
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
                    Write-Warning 'Issue with Get-TssLauncherAgent request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -is [pscustomobject]) {
                    [Thycotic.PowerShell.LauncherAgents.LauncherAgent](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.LauncherAgent]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
