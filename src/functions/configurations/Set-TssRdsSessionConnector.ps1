function Set-TssRdsSessionConnector {
    <#
    .SYNOPSIS
    Update the RDS Session Connector configuration

    .DESCRIPTION
    Update the RDS Session Connector configuration, which launches RDP sessions through a Remote Desktop Services collection. -Enabled is required on every call: the server rejects a patch without it (HTTP 500). The other parameters change only when passed. Returns the configuration after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowConnectionSharing
    Allow a connector session to be shared

    .PARAMETER CertificateSecretId
    Id of the secret that holds the connector certificate

    .PARAMETER Enabled
    Turn the session connector on (-Enabled) or off (-Enabled:$false). Required

    .PARAMETER SessionTimeoutInSeconds
    Session timeout in seconds

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRdsSessionConnector -TssSession $session -Enabled:$false

    Turn the RDS Session Connector off

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRdsSessionConnector -TssSession $session -Enabled -SessionTimeoutInSeconds 3600 -CertificateSecretId 42

    Turn the connector on with a one-hour timeout and the certificate in secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssRdsSessionConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssRdsSessionConnector.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.RdsSessionConnector')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $AllowConnectionSharing,

        [int]
        $CertificateSecretId,

        [Parameter(Mandatory)]
        [switch]
        $Enabled,

        [int]
        $SessionTimeoutInSeconds
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'rds-session-connector' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowConnectionSharing' {
                    $body.data.Add('allowConnectionSharing', @{ dirty = $true; value = [boolean]$AllowConnectionSharing })
                }
                'CertificateSecretId' {
                    $body.data.Add('certificateSecretId', @{ dirty = $true; value = $CertificateSecretId })
                }
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'SessionTimeoutInSeconds' {
                    $body.data.Add('sessionTimeoutInSeconds', @{ dirty = $true; value = $SessionTimeoutInSeconds })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Rds session connector", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssRdsSessionConnector request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.RdsSessionConnector](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.RdsSessionConnector]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
