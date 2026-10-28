function Request-TssSecretForceCheckout {
    <#
    .SYNOPSIS
    Request a force checkout of a secret another user has checked out

    .DESCRIPTION
    Files a request to take over a secret whose current checkout has run past its end time, for a user without the Force Check In permission.
    An approver grants it with Approve-TssSecretForceCheckout.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER ReasonForRequest
    Reason shown to the approvers

    .PARAMETER RequesterId
    ID of the user requesting the force checkout, normally the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Request-TssSecretForceCheckout -TssSession $session -Id 42 -RequesterId 7 -ReasonForRequest 'Checkout expired, need access for an incident'

    Requests a force checkout of secret 42 for user 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Request-TssSecretForceCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Request-TssSecretForceCheckout.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.ForceCheckout')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [string]
        $ReasonForRequest,

        [Parameter(Mandatory)]
        [int]
        $RequesterId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'request-force-check-out' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ReasonForRequest' {
                    $body.data.Add('reasonForRequest', $ReasonForRequest)
                }
                'RequesterId' {
                    $body.data.Add('requesterId', $RequesterId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret force checkout: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Request-TssSecretForceCheckout request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.ForceCheckout](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ForceCheckout]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
