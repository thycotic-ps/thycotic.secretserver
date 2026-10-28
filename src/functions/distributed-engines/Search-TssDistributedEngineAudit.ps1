function Search-TssDistributedEngineAudit {
    <#
    .SYNOPSIS
    Search the audit history of Distributed Engines

    .DESCRIPTION
    Searches the audit records of the Distributed Engines on a site, or on every site when -SiteId is omitted.
    Filter by engine with -EngineId and by text with -SearchTerm.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SiteId
    Site ID; omit for the engines of every site

    .PARAMETER EngineId
    Only audits of this engine

    .PARAMETER SearchTerm
    Text to match in the audit records

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineAudit -TssSession $session -SiteId 3

    Gets the audit records of every engine on site 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineAudit -TssSession $session -EngineId 7 -SearchTerm Activate

    Searches every site for audit records of engine 7 that mention Activate

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint without the site segment (distributed-engine/{siteId}/engine-audits), so the request fails.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int[]]
        $SiteId,

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
            Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            $siteIds = if ($SiteId) { $SiteId } else { 0 }
            foreach ($currentSiteId in $siteIds) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', $currentSiteId, 'engine-audits' -join '/'
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
                    Write-Warning 'Issue with Search-TssDistributedEngineAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.DistributedEngines.EngineAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DistributedEngines.EngineAudit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
