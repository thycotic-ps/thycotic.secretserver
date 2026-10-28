function Start-TssConfigurationRpc {
    <#
    .SYNOPSIS
    Run Remote Password Changing now

    .DESCRIPTION
    Starts the Remote Password Changing (RPC) scheduler immediately, so every pending password change is processed now instead of at the next RPC interval.
    This acts on all secrets with a pending password change, not on one secret. To change the password of one secret use Start-TssSecretChangePassword.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssConfigurationRpc -TssSession $session

    Process all pending password changes now

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationRpc

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationRpc.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.RpcRunNowResult')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'rpc', 'run-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Configuration rpc", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssConfigurationRpc request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.RpcRunNowResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.RpcRunNowResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
