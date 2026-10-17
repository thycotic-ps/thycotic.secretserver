function Invoke-TssSecretCheckout {
    <#
    .SYNOPSIS
    Check out a secret

    .DESCRIPTION
    Checks out a secret that requires check out and returns the response codes Secret Server sends back.
    Check the secret in again with Close-TssSecret.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssSecretCheckout -TssSession $session -Id 42

    Checks out secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssSecretCheckout -TssSession $session -Id 42
    Close-TssSecret -TssSession $session -Id 42

    Checks out secret 42 and checks it in again

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretCheckout.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.Checkout')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
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
                $uri = $TssSession.ApiUrl, 'secrets', $currentId, 'check-out' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssSecretCheckout request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.Checkout](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.Checkout]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
