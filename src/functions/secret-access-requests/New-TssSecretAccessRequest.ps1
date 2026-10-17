function New-TssSecretAccessRequest {
    <#
    .SYNOPSIS
    Create a secret access request

    .DESCRIPTION
    Creates an access request for a secret that requires approval before it can be viewed (Request Access on the secret, or a secret workflow).
    The request is created for the current user. The approvers are notified and the request stays Pending until it is approved, denied or canceled.
    The secret must require approval (otherwise the server answers API_AccessApprovalNotRequired). Pass -StartDate and -ExpirationDate: the v2 endpoint rejects a request without them, and a window that overlaps another pending request of the same user is rejected.
    Without -V2 the v1 endpoint is used, which reports a revoked request as Denied. With -V2 the v2 endpoint is used, which returns the Revoked state.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExpirationDate
    End of the requested access window

    .PARAMETER RequestComment
    Reason for the request, shown to the approvers

    .PARAMETER SecretId
    Secret ID to request access to

    .PARAMETER StartDate
    Start of the requested access window

    .PARAMETER TicketNumber
    Ticket number from the ticket system, when the secret requires one

    .PARAMETER TicketSystemId
    Ticket system ID, when the secret requires a ticket

    .PARAMETER V2
    Use the v2 endpoint. v2 returns the Revoked state; v1 reports a revoked request as Denied

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretAccessRequest -TssSession $session -SecretId 42 -RequestComment 'Patch window for app servers' -StartDate (Get-Date) -ExpirationDate (Get-Date).AddHours(4)

    Request four hours of access to secret 42, starting now

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretAccessRequest -TssSession $session -SecretId 42 -TicketSystemId 1 -TicketNumber CHG0012345 -V2

    Request access to secret 42 with a change ticket, using the v2 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/New-TssSecretAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/New-TssSecretAccessRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.AccessRequests.Request')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [datetime]
        $ExpirationDate,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [string]
        $RequestComment,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'V2')]
        [int]
        $SecretId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [datetime]
        $StartDate,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [string]
        $TicketNumber,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [int]
        $TicketSystemId,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'V2' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secret-access-requests' -join '/'
                    $body = @{ }
                    switch ($tssParams.Keys) {
                        'ExpirationDate' {
                            $body.Add('expirationDate', $ExpirationDate)
                        }
                        'RequestComment' {
                            $body.Add('requestComment', $RequestComment)
                        }
                        'SecretId' {
                            $body.Add('secretId', $SecretId)
                        }
                        'StartDate' {
                            $body.Add('startDate', $StartDate)
                        }
                        'TicketNumber' {
                            $body.Add('ticketNumber', $TicketNumber)
                        }
                        'TicketSystemId' {
                            $body.Add('ticketSystemId', $TicketSystemId)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secret-access-requests' -join '/'
                    $body = @{ }
                    switch ($tssParams.Keys) {
                        'ExpirationDate' {
                            $body.Add('expirationDate', $ExpirationDate)
                        }
                        'RequestComment' {
                            $body.Add('requestComment', $RequestComment)
                        }
                        'SecretId' {
                            $body.Add('secretId', $SecretId)
                        }
                        'StartDate' {
                            $body.Add('startDate', $StartDate)
                        }
                        'TicketNumber' {
                            $body.Add('ticketNumber', $TicketNumber)
                        }
                        'TicketSystemId' {
                            $body.Add('ticketSystemId', $TicketSystemId)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Secret: $SecretId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSecretAccessRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AccessRequests.Request](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AccessRequests.Request]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
