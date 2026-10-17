function Set-TssProtocolHandlerSettings {
    <#
    .SYNOPSIS
    Update the Protocol Handler install-time settings

    .DESCRIPTION
    Update the settings Secret Server injects into the Protocol Handler installer: whether install-time settings are on, whether auto update is turned off, and the domains or IP addresses the Protocol Handler may connect to. Only the parameters you pass are changed. Returns the settings after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ProtocolHandlerInstallTimeAllowedDomains
    Comma-separated domains or IP addresses the Protocol Handler may connect to

    .PARAMETER ProtocolHandlerInstallTimeDisableAutoUpdate
    Turn off Protocol Handler auto update at install time

    .PARAMETER ProtocolHandlerInstallTimeSettingsEnabled
    Inject the install-time settings into the Protocol Handler installer

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProtocolHandlerSettings -TssSession $session -ProtocolHandlerInstallTimeSettingsEnabled -ProtocolHandlerInstallTimeAllowedDomains 'ss.example.com'

    Turn on install-time settings and restrict the Protocol Handler to one Secret Server host

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssProtocolHandlerSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssProtocolHandlerSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ProtocolHandlerSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $ProtocolHandlerInstallTimeAllowedDomains,

        [switch]
        $ProtocolHandlerInstallTimeDisableAutoUpdate,

        [switch]
        $ProtocolHandlerInstallTimeSettingsEnabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'protocol-handler-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ProtocolHandlerInstallTimeAllowedDomains' {
                    $body.data.Add('protocolHandlerInstallTimeAllowedDomains', @{ dirty = $true; value = $ProtocolHandlerInstallTimeAllowedDomains })
                }
                'ProtocolHandlerInstallTimeDisableAutoUpdate' {
                    $body.data.Add('protocolHandlerInstallTimeDisableAutoUpdate', @{ dirty = $true; value = [boolean]$ProtocolHandlerInstallTimeDisableAutoUpdate })
                }
                'ProtocolHandlerInstallTimeSettingsEnabled' {
                    $body.data.Add('protocolHandlerInstallTimeSettingsEnabled', @{ dirty = $true; value = [boolean]$ProtocolHandlerInstallTimeSettingsEnabled })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Protocol handler settings", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProtocolHandlerSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ProtocolHandlerSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ProtocolHandlerSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
