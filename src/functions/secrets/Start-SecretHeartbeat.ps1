function Start-SecretHeartbeat {
    <#
    .SYNOPSIS
    Start a current password change

    .DESCRIPTION
    Start a current password change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssSecretHeartbeat -TssSession $session -Id 46

    Start a heartbeat operation on Secret 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Start-TssSecretHeartbeat

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Start-SecretHeartbeat.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'heartbeat' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParamsOther.Method) $uri")) { return }
                Write-Verbose "$($invokeParamsOther.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.id -eq $secret -and $restResponse.lastHeartbeatStatus -eq 'Pending') {
                    Write-Verbose "Heartbeat successfully started for Secret [$secret]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}