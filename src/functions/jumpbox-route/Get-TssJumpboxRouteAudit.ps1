function Get-TssJumpboxRouteAudit {
    <#
    .SYNOPSIS
    Get the audit trail of a jumpbox route

    .DESCRIPTION
    Returns one entry per change made to the jumpbox route with the given ID: who made it, when, the action, and any notes.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .PARAMETER SearchTerm
    Return only entries that match this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRouteAudit -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Returns the audit entries for the jumpbox route with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ' | Get-TssJumpboxRouteAudit -TssSession $session

    Returns the audit entries for every active jumpbox route with "DMZ" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('JumpboxRouteId')]
        [string[]]
        $Id,

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
                $uri = $TssSession.ApiUrl, 'jumpbox-route', $currentId, 'audit' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
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
                    Write-Warning 'Issue with Get-TssJumpboxRouteAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.JumpboxRoute.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.JumpboxRoute.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
