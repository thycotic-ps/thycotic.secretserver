function Stop-TssSecretChangePassword {
    <#
    .SYNOPSIS
    Stop a current password change

    .DESCRIPTION
    Stop a current password change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssSecretChangePassword -TssSession $session -Id 46

    Stop a current password change operation on secret 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Stop-TssSecretChangePassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Stop-TssSecretChangePassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Id
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
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'stop-password-change' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'


                if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $($invokeParams.Uri)")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.success) {
                    [PSCustomObject]@{
                        SecretId = $secret
                        Status   = $true
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}