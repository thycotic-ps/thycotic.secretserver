function Approve-TssSecretForceCheckout {
    <#
    .SYNOPSIS
    Approve a pending force checkout request on a secret

    .DESCRIPTION
    Approves a request, filed with Request-TssSecretForceCheckout, to take over a secret that another user has checked out past the checkout end time.
    The caller needs the Force Check In permission on the secret.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER Comment
    Comment recorded with the approval

    .PARAMETER RequesterUserId
    ID of the user whose request is approved

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Approve-TssSecretForceCheckout -TssSession $session -Id 42 -RequesterUserId 7 -Comment 'Approved for the maintenance window'

    Approves the force checkout request user 7 filed on secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Approve-TssSecretForceCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Approve-TssSecretForceCheckout.ps1

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
        $Comment,

        [Parameter(Mandatory)]
        [int]
        $RequesterUserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'approve-force-check-out-request' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Comment' {
                    $body.data.Add('comment', $Comment)
                }
                'RequesterUserId' {
                    $body.data.Add('requesterUserId', $RequesterUserId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret force checkout: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Approve-TssSecretForceCheckout request'
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
