function Get-TssLauncherAgentCollection {
    <#
    .SYNOPSIS
    Get a launcher agent collection

    .DESCRIPTION
    Get an Advanced Session Recording launcher agent collection by Id, active or inactive. An unknown Id returns nothing.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent collection Id

    .PARAMETER IncludeInactive
    Sent to Secret Server as includeInactive. Secret Server returns an inactive collection by Id with or without it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgentCollection -TssSession $session -Id 1

    Get launcher agent collection 1, active or not

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Collection')]
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
                $uri = $TssSession.ApiUrl, 'launcheragents', 'collections', $currentId -join '/'
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
                    Write-Warning 'Issue with Get-TssLauncherAgentCollection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -is [pscustomobject]) {
                    [Thycotic.PowerShell.LauncherAgents.Collection](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.Collection]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
