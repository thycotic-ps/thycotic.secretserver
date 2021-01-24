function Disable-Secret {
    <#
    .SYNOPSIS
    Disable a secret from Secret Server

    .DESCRIPTION
    Disables a secret from Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssSecret -TssSession $session -Id 93

    Disables secret 93

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret ID to disable (mark inactive)
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {

            foreach ($secret in $Id) {
                $uri = $TssSession.ApiUrl, "secrets", $secret.ToString() -join '/'

                $invokeParams.Uri = $Uri
                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess($secret, "$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue disabling secret [$secret]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($tssParams['Raw']) {
                    return $restResponse
                }
                if ($restResponse) {
                    [PSCustomObject]@{
                        Id         = $restResponse.id
                        ObjectType = $restResponse.objectType
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}