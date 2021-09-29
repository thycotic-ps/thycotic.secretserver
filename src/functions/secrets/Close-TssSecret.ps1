function Close-TssSecret {
    <#
    .SYNOPSIS
    Check-In a Secret

    .DESCRIPTION
    Check-In a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    CheckIn-TssSecret -TssSession $session -Id 86

    Check-In Secret 86

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    CheckIn-TssSecret -TssSession $session -Id 98 -ForceCheckIn

    Check-In Secret 98 applying ForceCheckIn

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secret = Get-TssSecret -TssSession $session -Id 42
    $scriptCred = $secret.GetCredential()
    Close-TssSecret -TssSession $session -Id 42

    Check-In Secret 42 after using it to get the username/password credential

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Close-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Close-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.Secrets.Summary')]
    [cmdletbinding()]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
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
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($protectParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($protectParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'check-in' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $checkInBody = @{}
                if ($restrictedParams.Count -gt 0) {
                    switch ($tssParams.Keys) {
                        'Comment' { $checkInBody.Add('comment', $Comment) }
                        'ForceCheckIn' { $checkInBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $checkInBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $checkInBody.Add('ticketSystemId', $TicketSystemId) }
                    }
                }

                if ($protectParams.ContainsKey('IncludeInactive')) {
                    $checkInBody.Add('includeInactive', [boolean]$IncludeInactive)
                }

                $invokeParams.Body = $checkInBody | ConvertTo-Json

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    . $ProcessResponse $apiResponse >$null
                } catch {
                    Write-Warning "Issue checking in Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}