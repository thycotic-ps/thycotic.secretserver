function Stop-PasswordChange {
    <#
    .SYNOPSIS
    Stop a current password change

    .DESCRIPTION
    Stop a current passwor change

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Stop-TssPasswordChange -TssSession $session -Id 46

    Stop a current password change operation on secret 46

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
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret.ToString(), 'stop-password-change' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    if (($_.ErrorDetails.Message | ConvertFrom-Json).Message) {
                        [PSCustomObject]@{
                            SecretId = $secret
                            Status = $false
                            Notes = ($_.ErrorDetails.Message | ConvertFrom-Json).Message
                        }
                    } else {
                        Write-Warning "Issue removing [$secret]"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }
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