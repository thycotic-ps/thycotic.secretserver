function Protect-Secret {
    <#
    .SYNOPSIS
    Check-In a Secret

    .DESCRIPTION
    Check-In a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secret = Get-TssSecret -TssSession $session -Id 42
    $scriptCred = $secret.GetCredential()
    Protect-TssSecret -TssSession $session -Id 42

    Check-In Secret 42 after using it to get the username/password credential

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Protect-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Protect-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('TssSecretSummary')]
    [cmdletbinding()]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Force check-in of the Secret
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Associated Ticket Number
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketNumber,

        # Associated Ticket System ID
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId,

        # Whether to include inactive secrets
        [switch]
        $IncludeInactive
    )
    begin {
        $protectParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($protectParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($protectParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.0000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'check-in' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $protectBody = @{}
                if ($restrictedParams.Count -gt 0) {
                    switch ($tssParams.Keys) {
                        'Comment' { $protectBody.Add('comment', $Comment) }
                        'ForceCheckIn' { $protectBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $protectBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $protectBody.Add('ticketSystemId', $TicketSystemId) }
                    }
                }

                if ($protectParams.ContainsKey('IncludeInactive')) {
                    $protectBody.Add('includeInactive',[boolean]$IncludeInactive)
                }
                if ($protectParams.ContainsKey('NewPassword')) {
                    $protectBody.Add('newPassword',$NewPassword)
                }

                $invokeParams.Body = $protectBody | ConvertTo-Json

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue checking in Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    if (-not $restResponse.lastPasswordChangeAttempt) {
                        $restResponse.lastPasswordChangeAttempt = [datetime]::MinValue
                    }
                    if (-not $restResponse.lastAccessed) {
                        $restResponse.lastAccessed = [datetime]::MinValue
                    }
                    if (-not $restResponse.createDate) {
                        $restResponse.createDate = [datetime]::MinValue
                    }

                    [TssSecretSummary]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}