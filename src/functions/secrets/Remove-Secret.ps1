function Remove-Secret {
    <#
    .SYNOPSIS
    Delete a secret from Secret Server

    .DESCRIPTION
    Delete a secret from Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSecret -TssSession $session -Id 93

    Delete Secret ID 93

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Remove-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Remove-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID to disable (mark inactive)
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
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
                $uri = $TssSession.ApiUrl, "secrets", $secret -join '/'

                $invokeParams.Uri = $Uri

                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue disabling secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}