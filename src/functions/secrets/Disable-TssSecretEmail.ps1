function Disable-TssSecretEmail {
    <#
    .SYNOPSIS
    Disables the email setting for a Secret

    .DESCRIPTION
    Disables the email setting for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssSecretEmail -TssSession $session -Id 28 -WhenViewed

    Disable Secret 28's Email When Viewed setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssSecretEmail -TssSession $session -Id 42,43,45 -WhenViewed

    Disable Email When Viewed setting on Secret IDs 42, 43, and 45

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Disable-TssSecretEmail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Disable-TssSecretEmail.ps1

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

        # Email when changed to true
        [switch]
        $WhenChanged,

        # Email when viewed to true
        [switch]
        $WhenViewed,

        # Email when HB fails to true
        [switch]
        $WhenHeartbeatFails,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Associated Ticket Number
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketNumber,

        #Associated Ticket System ID
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
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'email' -join '/'
                $invokeParams.Uri = $uri

                # data object for Email Settings
                $emailBody = @{
                    data = @{ }
                }

                if ($tssParams.ContainsKey('WhenChanged')) {
                    $sendEmailWhenChanged = @{
                        dirty = $true
                        value = $false
                    }
                    $emailBody.data.Add('sendEmailWhenChanged', $sendEmailWhenChanged)
                }
                if ($tssParams.ContainsKey('WhenViewed')) {
                    $sendEmailWhenViewed = @{
                        dirty = $true
                        value = $false
                    }
                    $emailBody.data.Add('sendEmailWhenViewed', $sendEmailWhenViewed)
                }
                if ($tssParams.ContainsKey('WhenHeartbeatFails')) {
                    $sendEmailWhenHeartbeatFails = @{
                        dirty = $true
                        value = $false
                    }
                    $emailBody.data.Add('sendEmailWhenHeartbeatFails', $sendEmailWhenHeartbeatFails)
                }

                $invokeParams.Method = 'PATCH'
                $invokeParams.Body = $emailBody | ConvertTo-Json -Depth 5

                if ($restrictedParams.Count -gt 0) {
                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", 'Pre-check out secret for setting email settings')) {
                        $writeViewParams = @{
                            TssSession     = $TssSession
                            Id             = $secret
                            Comment        = $Comment
                            TicketNumber   = $TicketNumber
                            TicketSystemId = $TicketSystemId
                        }
                        Write-TssSecretAccessRequestViewComment @writeViewParams

                        $checkoutParams = @{
                            TssSession     = $TssSession
                            Id             = $secret
                            Comment        = $Comment
                            TicketNumber   = $TicketNumber
                            TicketSystemId = $TicketSystemId
                        }
                        Open-TssSecret @checkoutParams
                    }
                }
                if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue configuring [$secret] email settings, verify Email Server is configured in Secret Server"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenChanged' -and $tssParams.ContainsKey('WhenChanged')) {
                        Write-Verbose "Secret [$secret] email setting [Send Email When Changed] disabled"
                    }
                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenViewed' -and $tssParams.ContainsKey('WhenViewed')) {
                        Write-Verbose "Secret [$secret] email setting [Send Email When Viewed] disabled"
                    }
                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenHeartbeatFails' -and $tssParams.ContainsKey('WhenHeartbeatFails')) {
                        Write-Verbose "Secret [$secret] email setting [Send Email When Heartbeat Fails] disabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}