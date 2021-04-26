function Update-Secret {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
    [OutputType('TssSecret')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Input object obtained via Get-TssSecretStub
        [Parameter(Mandatory, Position = 1)]
        [TssSecret]
        $Secret,

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
        $invokeParams = . $GetInvokeTssParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($updateParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.0000' $PSCmdlet.MyInvocation

            $secretId = $Secret.Id
            $uri = $TssSession.ApiUrl, 'secrets', $secretId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $updateBody = $Secret

            if ($restrictedParams.Count -gt 0) {
                switch ($updateParams.Keys) {
                    'Comment' { $updateBody.Add('comment', $Comment) }
                    'ForceCheckIn' { $updateBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                    'TicketNumber' { $updateBody.Add('ticketNumber', $TicketNumber) }
                    'TicketSystemId' { $updateBody.Add('ticketSystemId', $TicketSystemId) }
                }
            }
            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 5

            if ($PSCmdlet.ShouldProcess("Secret ID: $secretId ", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $updateResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue setting field $Field on secret [$secretId ]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($updateResponse.id -eq $secretId) {
                    [TssSecret]$updateResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}