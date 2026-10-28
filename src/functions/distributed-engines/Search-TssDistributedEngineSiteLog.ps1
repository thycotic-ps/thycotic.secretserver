function Search-TssDistributedEngineSiteLog {
    <#
    .SYNOPSIS
    Search the logs of a Distributed Engine site

    .DESCRIPTION
    Searches the log entries of a site, newest first: date, engine name and message.
    Filter by engine with -EngineId and by text with -SearchTerm.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Site ID

    .PARAMETER EngineId
    Only logs of this engine

    .PARAMETER SearchTerm
    Text to match in the engine name or the message

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineSiteLog -TssSession $session -Id 3 -SearchTerm error

    Gets the log entries of site 3 that mention error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineSiteLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineSiteLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SiteId')]
        [int[]]
        $Id,

        [int]
        $EngineId,

        [string]
        $SearchTerm
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
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', $currentId, 'logs' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'EngineId' {
                        $queryParams += "filter.engineId=$($EngineId)"
                    }
                    'SearchTerm' {
                        $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
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
                    Write-Warning 'Issue with Search-TssDistributedEngineSiteLog request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.DistributedEngines.SiteLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DistributedEngines.SiteLog]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
