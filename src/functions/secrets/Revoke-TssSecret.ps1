function Revoke-TssSecret {
    <#
    .SYNOPSIS
    Expire a secret

    .DESCRIPTION
    Expire a secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Revoke-TssSecret -TssSession $session -Id 42

    Expire Secret ID 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Revoke-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Revoke-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Double lock password, provie as a secure string
        [Parameter(ParameterSetName = 'restricted')]
        [securestring]
        $DoublelockPassword,

        # Check in the secret if it is checked out
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Include secrets that are inactive/disabled
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $IncludeInactive,

        # Associated ticket number (required for ticket integrations)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($tssParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'expire' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $expireBody = @{}
                $expireBody.responseType = 'json'
                if ($restrictedParams.Count -gt 0) {
                    switch ($tssParams.Keys) {
                        'Comment' { $expireBody.Add('comment', $Comment) }
                        'IncludeInactive' { $expireBody.Add('includeInactive', [boolean]$IncludeInactive) }
                        'ForceCheckIn' { $expireBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $expireBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $expireBody.Add('ticketSystemId', $TicketSystemId) }
                        'DoublelockPassword' {
                            $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                            $expireBody.Add('doubleLockPassword', $passwd)
                        }
                    }
                }
                $invokeParams.Body = $expireBody | ConvertTo-Json

                if (-not $PSCmdlet.ShouldProcess($secret, "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue expring Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse -and $restResponse.id -eq $secret) {
                    Write-Host "Secret [$secret] expired"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}