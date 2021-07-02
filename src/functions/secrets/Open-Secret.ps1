function Open-Secret {
    <#
    .SYNOPSIS
    Checkout a Secret

    .DESCRIPTION
    Checkout a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Checkout-TssSecret -TssSession $session -Id 72 -TicketId 'N000354'

    Checkout Secret ID 72 providing ticket number required by Ticket Integration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Open-TssSecret -TssSession $session -Id 376

    Checkout Secret ID 376

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Open-TssSecret -TssSession $session -Id 42 -Comment "CI process"

    Checkout Secret ID 42 providing a comment (Secret configured to checkout and require comment)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Open-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Open-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecret')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Alias("SecretId")]
        [Parameter(ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [string]
        $Comment,

        # Associated ticket number (required for ticket integrations)
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [int]
        $TicketSystemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeViewCommentParams = . $GetInvokeTssParams $TssSession
        $invokeCheckoutParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            foreach($secret in $Id) {

                # Checkout endpoint requires a pre-checkout comment be sent
                $restrictedBody = @{}
                switch ($tssParams.Keys) {
                    'Comment' { $restrictedBody.Add('comment',$Comment) }
                    'TicketNumber' { $restrictedBody.Add('ticketNumber', $TicketNumber) }
                    'TicketSystemId' { $restrictedBody.Add('ticketSystemId', $TicketSystemId) }
                }
                if ($restrictedBody.Count -gt 0) {
                    $uriViewComment = $TssSession.ApiUrl, 'secret-access-requests', 'secrets', $secret, 'view-comment' -join '/'

                    $invokeViewCommentParams.Body = $restrictedBody | ConvertTo-Json
                    $invokeViewCommentParams.Uri = $uriViewComment
                    $invokeViewCommentParams.Method = 'POST'

                    if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeViewCommentParams.Method) $uriViewComment with: `n$($invokeViewCommentParams.Body)`n")) {
                        Write-Verbose "Performing the operation $($invokeViewCommentParams.Method) $uriViewComment with:`n$($invokeViewCommentParams.Body)`n"
                        try {
                            . $InvokeApi @invokeViewCommentParams >$null
                        } catch {
                            Write-Warning "Issue adding view comment for Secret [$secret]"
                            $err = $_
                            . $ErrorHandling $err
                        }
                    }
                }
                # Secret Checkout
                $uriCheckout = $TssSession.ApiUrl, 'secrets', $secret, 'check-out' -join '/'
                $invokeCheckoutParams.Uri = $uriCheckout
                $invokeCheckoutParams.Method = 'POST'
                if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeCheckoutParams.Method) $uriCheckout")) {
                    Write-Verbose "Performing the operation $($invokeCheckoutParams.Method) $uriCheckout"
                    try {
                        . $InvokeApi @invokeCheckoutParams >$null
                    } catch {
                        Write-Warning "Issue checking out Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}