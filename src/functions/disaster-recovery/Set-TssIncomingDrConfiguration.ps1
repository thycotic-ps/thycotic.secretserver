function Set-TssIncomingDrConfiguration {
    <#
    .SYNOPSIS
    Update the Disaster Recovery incoming configuration

    .DESCRIPTION
    Changes the Disaster Recovery settings of this Secret Server as a data replica. Only the values you pass are changed.
    Enabling data replication needs a valid data source URL and data source key (the DataSourceUrl and DataSourceKey of the data source, from Get-TssOutgoingDrConfiguration there). Changing the data source settings starts a new handshake with the data source.
    Enabling replication makes this Secret Server a data replica of the data source. -DataPackageStoragePath and -ReplicationIntervalMinutes apply to on-premises Secret Server only and are ignored on Secret Server Cloud.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DataPackageStoragePath
    Folder path where data packages are stored (on-premises only)

    .PARAMETER DataReplicationEnabled
    Enable data replication from the data source. Pass -DataReplicationEnabled:$false to disable it

    .PARAMETER DataSourceCertificatePinningKeyHashSha256
    SHA-256 hash of the data source certificate public key to pin. An empty string removes the pin

    .PARAMETER DataSourceKey
    Public key of the data source, the DataSourceKey shown by Get-TssOutgoingDrConfiguration on the data source

    .PARAMETER DataSourceUrl
    URL of the Secret Server data source

    .PARAMETER ForceLegacyReplication
    Use the legacy replication protocol

    .PARAMETER ReplicationIntervalMinutes
    Minutes between replication runs (on-premises only)

    .PARAMETER UserAccountOption
    How replicated user accounts are imported: MirrorSource (same state as the data source) or ImportDisabled

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIncomingDrConfiguration -TssSession $session -ReplicationIntervalMinutes 30

    Replicate every 30 minutes

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $source = Get-TssOutgoingDrConfiguration -TssSession $sourceSession
    Set-TssIncomingDrConfiguration -TssSession $session -DataSourceUrl $source.DataSourceUrl -DataSourceKey $source.DataSourceKey -DataReplicationEnabled

    Make this Secret Server a data replica of the Secret Server in $sourceSession

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssIncomingDrConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssIncomingDrConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $DataPackageStoragePath,

        [switch]
        $DataReplicationEnabled,

        [string]
        $DataSourceCertificatePinningKeyHashSha256,

        [string]
        $DataSourceKey,

        [string]
        $DataSourceUrl,

        [switch]
        $ForceLegacyReplication,

        [int]
        $ReplicationIntervalMinutes,

        [ValidateSet('MirrorSource', 'ImportDisabled')]
        [string]
        $UserAccountOption
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'incoming-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DataPackageStoragePath' {
                    $body.data.Add('dataPackageStoragePath', @{ dirty = $true; value = $DataPackageStoragePath })
                }
                'DataReplicationEnabled' {
                    $body.data.Add('dataReplicationEnabled', @{ dirty = $true; value = [boolean]$DataReplicationEnabled })
                }
                'DataSourceCertificatePinningKeyHashSha256' {
                    $body.data.Add('dataSourceCertificatePinningKeyHashSha256', @{ dirty = $true; value = $DataSourceCertificatePinningKeyHashSha256 })
                }
                'DataSourceKey' {
                    $body.data.Add('dataSourceKey', @{ dirty = $true; value = $DataSourceKey })
                }
                'DataSourceUrl' {
                    $body.data.Add('dataSourceUrl', @{ dirty = $true; value = $DataSourceUrl })
                }
                'ForceLegacyReplication' {
                    $body.data.Add('forceLegacyReplication', @{ dirty = $true; value = [boolean]$ForceLegacyReplication })
                }
                'ReplicationIntervalMinutes' {
                    $body.data.Add('replicationIntervalMinutes', @{ dirty = $true; value = $ReplicationIntervalMinutes })
                }
                'UserAccountOption' {
                    $body.data.Add('userAccountOption', @{ dirty = $true; value = $UserAccountOption })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Incoming DR configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssIncomingDrConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
