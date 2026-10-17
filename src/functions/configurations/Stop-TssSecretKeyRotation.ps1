function Stop-TssSecretKeyRotation {
    <#
    .SYNOPSIS
    Cancel a running secret key rotation

    .DESCRIPTION
    Requests cancellation of the Rotate Secret Keys run in progress and returns the rotation status.
    Nothing changes when no rotation is running.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssSecretKeyRotation -TssSession $session

    Cancels the secret key rotation in progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Stop-TssSecretKeyRotation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Stop-TssSecretKeyRotation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'security', 'cancel-rotate-secret-keys' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Secret key rotation", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Stop-TssSecretKeyRotation request'
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
