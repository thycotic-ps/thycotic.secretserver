function Start-TssSecretChangePassword {
    <#
    .SYNOPSIS
    Start a current password change

    .DESCRIPTION
    Start a current password change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssSecretChangePassword -TssSession $session -Id 46

    Start a current password change operation on secret 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Start-TssSecretChangePassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Start-TssSecretChangePassword.ps1

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
        $Id,

        # Next Password Type, allowed Manual or Random
        [Parameter(Mandatory)]
        [ValidateSet('Manual', 'Random')]
        [string]
        $Type,

        # Manual Next Password to use
        [securestring]
        $NextPassword
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Write-TssInternalNote $PSCmdlet.MyInvocation
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'change-password-now' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $rpcBody = @{ data = @{ } }
                switch ($Type) {
                    'Manual' {
                        if ($tssParams.ContainsKey('NextPassword')) {
                            $rpcBody.data.Add('NextPassword', [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($NextPassword)))
                            $rpcBody.data.Add('PasswordType', 1)
                        } else {
                            Write-Error '-NextPassword parameter must be provided when using PasswordType of [Manual]'
                            return
                        }
                    }
                    'Random' {
                        if ($tssParams.ContainsKey('NextPassword')) {
                            Write-Error '-NextPassword parameter cannot be used with PasswordType of [Random]'
                            return
                        } else {
                            $rpcBody.data.Add('NextPassword', $null)
                            $rpcBody.data.Add('PasswordType', 0)
                        }
                    }
                }
                $invokeParams.Body = $rpcBody | ConvertTo-Json

                if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.success -eq $false) {
                    Write-Warning "Password Change not successful on Secret [$secret]"
                } else {
                    Write-Verbose "Password Change successfully started on Secret [$secret]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}