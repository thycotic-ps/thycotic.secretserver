function Get-TssTicketSystemOverride {
    <#
    .SYNOPSIS
    Get a ticket number override request

    .DESCRIPTION
    Returns one ticket number override request: ticket number, secret, requester and reason, approver, state and expiration, and whether the current user can approve it.
    Secret Server answers Access denied when the request does not exist or is not visible to the current user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Ticket number override request ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTicketSystemOverride -TssSession $session -Id 12

    Get override request 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystemOverride -TssSession $session -RequestType ApprovalRequests -State Pending | Get-TssTicketSystemOverride -TssSession $session | Where-Object CanApprove

    Get the pending override requests the current user can approve

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverride

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverride.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.TicketSystems.Override')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TicketSystemOverrideId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'ticket-systems', 'overrides', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssTicketSystemOverride request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.TicketSystems.Override](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.Override]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
