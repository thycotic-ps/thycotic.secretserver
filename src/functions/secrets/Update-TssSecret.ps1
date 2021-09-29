function Update-TssSecret {
    <#
    .SYNOPSIS
    Update a Secret

    .DESCRIPTION
    Update a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secret = Get-TssSecret -TssSession $session -Id 42
    $secret.SiteId = 2
    Update-TssSecret -TssSession $session $secret

    Update Secret ID 42, setting SiteID to Site 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.Secret')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Input object obtained via Get-TssSecretStub or Get-TssSecret
        [Parameter(Mandatory, Position = 1)]
        [Thycotic.PowerShell.Secrets.Secret]
        $Secret,

        # Include inactive Secrets
        [switch]
        $IncludeInactive,

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
        $TicketSystemId
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($updateParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            $secretId = $Secret.Id
            $uri = $TssSession.ApiUrl, 'secrets', $secretId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $updateBody = $Secret | ConvertTo-Json | ConvertFrom-Json
            if ($updateParams.ContainsKey('IncludeInactive')) {
                $updateBody.PSObject.Properties.Add([PSNoteProperty]::new('includeInactive',[boolean]$IncludeInactive))
            }
            if ($restrictedParams.Count -gt 0) {
                switch ($updateParams.Keys) {
                    'Comment' { $updateBody.PSObject.Properties.Add([PSNoteProperty]::new('comment', $Comment)) }
                    'ForceCheckIn' { $updateBody.PSObject.Properties.Add([PSNoteProperty]::new('forceCheckIn', [boolean]$ForceCheckIn)) }
                    'TicketNumber' { $updateBody.PSObject.Properties.Add([PSNoteProperty]::new('ticketNumber', $TicketNumber)) }
                    'TicketSystemId' { $updateBody.PSObject.Properties.Add([PSNoteProperty]::new('ticketSystemId', $TicketSystemId)) }
                }
            }
            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 5

            if ($PSCmdlet.ShouldProcess("Secret ID: $secretId ", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $updateResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating secret [$secretId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($updateResponse.id -eq $secretId) {
                    [Thycotic.PowerShell.Secrets.Secret]$updateResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}