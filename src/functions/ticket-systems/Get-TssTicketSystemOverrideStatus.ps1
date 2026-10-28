function Get-TssTicketSystemOverrideStatus {
    <#
    .SYNOPSIS
    Get the approval status of a ticket number override request

    .DESCRIPTION
    Returns whether a ticket number override request the current user made is approved. A lighter call than Get-TssTicketSystemOverride, for polling a request.
    IsApproved is empty while the request is pending, True once approved and False once denied.
    Only the requester can read the status: Secret Server answers Access denied for anyone else and when the request does not exist.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Ticket number override request ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTicketSystemOverrideStatus -TssSession $session -Id 12

    Check whether override request 12 is approved

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverrideStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverrideStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.TicketSystems.OverrideStatus')]
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
                $uri = $TssSession.ApiUrl, 'ticket-systems', 'override', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssTicketSystemOverrideStatus request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.TicketSystems.OverrideStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.OverrideStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
