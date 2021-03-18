function Enable-SecretEmail {
    <#
    .SYNOPSIS
    Enables the email setting for a Secret

    .DESCRIPTION
    Enables the email setting for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssSecretEmail -TssSession $session -Id 28 -WhenViewed

    Enable Secret 28's Email When Viewed setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssSecretEmail -TssSession $session -Id 42,43,45 -WhenViewed

    Enable Email When Viewed setting on Secret IDs 42, 43, and 45

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Disable-TssSecretEmail

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
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
        $WhenHeartbeatFails
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
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
                        value = $true
                    }
                    $emailBody.data.Add('sendEmailWhenChanged',$sendEmailWhenChanged)
                }
                if ($tssParams.ContainsKey('WhenViewed')) {
                    $sendEmailWhenViewed = @{
                        dirty = $true
                        value = $true
                    }
                    $emailBody.data.Add('sendEmailWhenViewed',$sendEmailWhenViewed)
                }
                if ($tssParams.ContainsKey('WhenHeartbeatFails')) {
                    $sendEmailWhenHeartbeatFails = @{
                        dirty = $true
                        value = $true
                    }
                    $emailBody.data.Add('sendEmailWhenHeartbeatFails',$sendEmailWhenHeartbeatFails)
                }


                $invokeParams.Method = 'PATCH'
                $invokeParams.Body = $emailBody | ConvertTo-Json -Depth 5

                if ($restrictedParams.Count -gt 0) {
                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", "Pre-check out secret for setting email settings")) {
                        . $CheckOutSecret $TssSession $tssParams $secret
                    }
                }
                if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
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
            Write-Warning "No valid session found"
        }
    }
}