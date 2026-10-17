function Start-TssSecretKeyRotation {
    <#
    .SYNOPSIS
    Start a secret key rotation

    .DESCRIPTION
    Requests a Rotate Secret Keys run, which re-encrypts every secret with newly generated keys, and returns the rotation status.
    The rotation runs in the background: follow it with Get-TssSecretKeyRotationStatus and cancel it with Stop-TssSecretKeyRotation.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssSecretKeyRotation -TssSession $session -Confirm:$false

    Starts a secret key rotation without prompting

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssSecretKeyRotation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssSecretKeyRotation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.SecretKeyRotationStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'security', 'rotate-secret-keys' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Secret key rotation", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssSecretKeyRotation request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SecretKeyRotationStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SecretKeyRotationStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
