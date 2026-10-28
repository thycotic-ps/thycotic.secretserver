function Set-TssDistributedEngineSettings {
    <#
    .SYNOPSIS
    Update the feature settings of a Distributed Engine or of a site default

    .DESCRIPTION
    Updates engine settings by settings ID (-EngineSettingsId, as returned by Get-TssDistributedEngineSettings) or for one engine (-EngineId).
    Only the parameters provided are sent; every other setting is unchanged.
    Returns the updated settings.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EngineSettingsId
    Engine settings ID, as returned by Get-TssDistributedEngineSettings (0 means the engine has no settings of its own; use -EngineId)

    .PARAMETER EngineId
    Distributed Engine ID, to update the settings of that engine

    .PARAMETER AdSyncEnabled
    Process directory services synchronization work

    .PARAMETER AdvancedAuditingEnabled
    Process advanced auditing work

    .PARAMETER ExternalVaultsEnabled
    Process external vault work

    .PARAMETER FipsEnabled
    Require FIPS compliance on the engine

    .PARAMETER LocalAccountDiscoveryEnabled
    Process local account discovery work

    .PARAMETER LogLevel
    Engine log level: All, Debug, Info, Warn, Error or Off

    .PARAMETER PasswordChangingEnabled
    Process secret remote password changing work

    .PARAMETER RdpGatewayEnabled
    Process RDP gateway work

    .PARAMETER RdpProxyCertificateSecretId
    ID of the secret holding the RDP proxy certificate

    .PARAMETER RdpProxyEnabled
    Process RDP proxy work

    .PARAMETER SecretWorkflowEnabled
    Process secret workflow work

    .PARAMETER SecurityAnalyticsEnabled
    Process security analytics work

    .PARAMETER ServiceAccountManagementEnabled
    Process service account management work

    .PARAMETER SshProxyEnabled
    Process SSH proxy work

    .PARAMETER SshTerminalEnabled
    Process SSH terminal work

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineSettings -TssSession $session -EngineId 7 -SshProxyEnabled:$false -LogLevel Warn

    Stops Distributed Engine 7 from processing SSH proxy work and sets its log level to Warn

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSettings -TssSession $session -SiteId 1 | Set-TssDistributedEngineSettings -TssSession $session -PasswordChangingEnabled

    Turns on password changing in the default engine settings of site 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Settings', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Settings')]
        [int]
        $EngineSettingsId,

        [Parameter(Mandatory, ParameterSetName = 'Engine')]
        [int]
        $EngineId,

        [switch]
        $AdSyncEnabled,

        [switch]
        $AdvancedAuditingEnabled,

        [switch]
        $ExternalVaultsEnabled,

        [switch]
        $FipsEnabled,

        [switch]
        $LocalAccountDiscoveryEnabled,

        [ValidateSet('All', 'Debug', 'Info', 'Warn', 'Error', 'Off')]
        [string]
        $LogLevel,

        [switch]
        $PasswordChangingEnabled,

        [switch]
        $RdpGatewayEnabled,

        [int]
        $RdpProxyCertificateSecretId,

        [switch]
        $RdpProxyEnabled,

        [switch]
        $SecretWorkflowEnabled,

        [switch]
        $SecurityAnalyticsEnabled,

        [switch]
        $ServiceAccountManagementEnabled,

        [switch]
        $SshProxyEnabled,

        [switch]
        $SshTerminalEnabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Engine' {
                    $uri = $TssSession.ApiUrl, 'distributed-engine', 'engine-settings', 'engine', $EngineId -join '/'
                    $target = "Distributed Engine: $EngineId"
                }
                default {
                    $uri = $TssSession.ApiUrl, 'distributed-engine', 'engine-settings', $EngineSettingsId -join '/'
                    $target = "Engine settings: $EngineSettingsId"
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AdSyncEnabled' {
                    $body.data.Add('adSyncEnabled', @{ dirty = $true; value = [boolean]$AdSyncEnabled })
                }
                'AdvancedAuditingEnabled' {
                    $body.data.Add('advancedAuditingEnabled', @{ dirty = $true; value = [boolean]$AdvancedAuditingEnabled })
                }
                'ExternalVaultsEnabled' {
                    $body.data.Add('externalVaultsEnabled', @{ dirty = $true; value = [boolean]$ExternalVaultsEnabled })
                }
                'FipsEnabled' {
                    $body.data.Add('fipsEnabled', @{ dirty = $true; value = [boolean]$FipsEnabled })
                }
                'LocalAccountDiscoveryEnabled' {
                    $body.data.Add('localAccountDiscoveryEnabled', @{ dirty = $true; value = [boolean]$LocalAccountDiscoveryEnabled })
                }
                'LogLevel' {
                    $body.data.Add('logLevel', @{ dirty = $true; value = $LogLevel })
                }
                'PasswordChangingEnabled' {
                    $body.data.Add('passwordChangingEnabled', @{ dirty = $true; value = [boolean]$PasswordChangingEnabled })
                }
                'RdpGatewayEnabled' {
                    $body.data.Add('rdpGatewayEnabled', @{ dirty = $true; value = [boolean]$RdpGatewayEnabled })
                }
                'RdpProxyCertificateSecretId' {
                    $body.data.Add('rdpProxyCertificateSecretId', @{ dirty = $true; value = $RdpProxyCertificateSecretId })
                }
                'RdpProxyEnabled' {
                    $body.data.Add('rdpProxyEnabled', @{ dirty = $true; value = [boolean]$RdpProxyEnabled })
                }
                'SecretWorkflowEnabled' {
                    $body.data.Add('secretWorkflowEnabled', @{ dirty = $true; value = [boolean]$SecretWorkflowEnabled })
                }
                'SecurityAnalyticsEnabled' {
                    $body.data.Add('securityAnalyticsEnabled', @{ dirty = $true; value = [boolean]$SecurityAnalyticsEnabled })
                }
                'ServiceAccountManagementEnabled' {
                    $body.data.Add('serviceAccountManagementEnabled', @{ dirty = $true; value = [boolean]$ServiceAccountManagementEnabled })
                }
                'SshProxyEnabled' {
                    $body.data.Add('sshProxyEnabled', @{ dirty = $true; value = [boolean]$SshProxyEnabled })
                }
                'SshTerminalEnabled' {
                    $body.data.Add('sshTerminalEnabled', @{ dirty = $true; value = [boolean]$SshTerminalEnabled })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess($target, "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDistributedEngineSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.EngineSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.EngineSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
