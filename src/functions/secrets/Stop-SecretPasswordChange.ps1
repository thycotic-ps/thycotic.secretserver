function Stop-SecretPasswordChange {
    <#
    .SYNOPSIS
    Stop a current password change

    .DESCRIPTION
    Stop a current password change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssSecretPasswordChange -TssSession $session -Id 46

    Stop a current password change operation on secret 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Stop-TssSecretPasswordChange

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret Id
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
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret.ToString(), 'stop-password-change' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'


                if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.success) {
                    [PSCustomObject]@{
                        SecretId = $secret
                        Status = $true
                        Notes = $null
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}