function Search-TssTicketSystemOverride {
    <#
    .SYNOPSIS
    Search ticket number override requests

    .DESCRIPTION
    Returns ticket number override requests: requests to use a ticket number that the ticket system rejected, when the ticket system allows overrides.
    By default the requests the current user made; -RequestType ApprovalRequests returns the requests the current user can approve.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER RequestType
    MyRequests (the default) returns the requests the current user made; ApprovalRequests returns the requests the current user can approve

    .PARAMETER State
    Return only the requests in this state; all states when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystemOverride -TssSession $session -RequestType ApprovalRequests -State Pending

    List the override requests waiting on the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystemOverride -TssSession $session -State Approved

    List the approved override requests the current user made

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystemOverride

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystemOverride.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.TicketSystems.OverrideSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('MyRequests', 'ApprovalRequests')]
        [string]
        $RequestType,

        [ValidateSet('Pending', 'Denied', 'Approved', 'RequestExpired')]
        [string]
        $State
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ticket-systems', 'overrides' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'RequestType' {
                    $queryParams += "filter.requestType=$([uri]::EscapeDataString($RequestType))"
                }
                'State' {
                    $queryParams += "filter.state=$([uri]::EscapeDataString($State))"
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
                Write-Warning 'Issue with Search-TssTicketSystemOverride request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.TicketSystems.OverrideSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.TicketSystems.OverrideSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
