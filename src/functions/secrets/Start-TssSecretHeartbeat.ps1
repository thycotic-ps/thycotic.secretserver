function Start-TssSecretHeartbeat {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Start-TssSecretHeartbeat

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Start-SecretHeartbeat.ps1

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
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'heartbeat' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParamsOther.Method) $($invokeParams.Uri)")) { return }
                Write-Verbose "$($invokeParamsOther.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
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