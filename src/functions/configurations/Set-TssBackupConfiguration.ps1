function Set-TssBackupConfiguration {
    <#
    .SYNOPSIS
    Set the Secret Server backup configuration

    .DESCRIPTION
    Updates the backup configuration: web application and database backup folders, the backup schedule, and how many backups to keep. Returns the updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER BackupDatabasePath
    Folder the database backup is written to

    .PARAMETER BackupFailureNotification
    Send a notification when a backup fails

    .PARAMETER BackupPath
    Folder the web application backup is written to

    .PARAMETER BackupStartDateTime
    Date and time the backup schedule starts

    .PARAMETER ConfigurationSqlBackupTimeoutMinutes
    Minutes to wait for the database backup before it times out

    .PARAMETER CopyOnlyDatabaseBackup
    Take copy-only database backups, which leave the SQL Server backup chain unchanged

    .PARAMETER EnableDatabaseBackup
    Back up the database

    .PARAMETER EnableScheduledBackup
    Run backups on a schedule

    .PARAMETER EnableTmsBackup
    Back up the TMS installation

    .PARAMETER EnableWebApplicationBackup
    Back up the web application files

    .PARAMETER NumberOfBackupsToKeep
    Number of backups to keep

    .PARAMETER RepeatDays
    Days between scheduled backups

    .PARAMETER RepeatHours
    Hours between scheduled backups

    .PARAMETER RepeatMinutes
    Minutes between scheduled backups

    .PARAMETER TmsInstallationPath
    TMS installation folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssBackupConfiguration -TssSession $session -EnableDatabaseBackup -BackupDatabasePath 'D:\Backup\SecretServer' -NumberOfBackupsToKeep 7

    Back up the database to D:\Backup\SecretServer and keep 7 backups

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssBackupConfiguration -TssSession $session -EnableScheduledBackup:$false

    Turn off scheduled backups

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssBackupConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssBackupConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud manages its own backups and can reject this request.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.Backup')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $BackupDatabasePath,

        [switch]
        $BackupFailureNotification,

        [string]
        $BackupPath,

        [datetime]
        $BackupStartDateTime,

        [int]
        $ConfigurationSqlBackupTimeoutMinutes,

        [switch]
        $CopyOnlyDatabaseBackup,

        [switch]
        $EnableDatabaseBackup,

        [switch]
        $EnableScheduledBackup,

        [switch]
        $EnableTmsBackup,

        [switch]
        $EnableWebApplicationBackup,

        [int]
        $NumberOfBackupsToKeep,

        [int]
        $RepeatDays,

        [int]
        $RepeatHours,

        [int]
        $RepeatMinutes,

        [string]
        $TmsInstallationPath
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'backup' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'BackupDatabasePath' {
                    $body.data.Add('backupDatabasePath', @{ dirty = $true; value = $BackupDatabasePath })
                }
                'BackupFailureNotification' {
                    $body.data.Add('backupFailureNotification', @{ dirty = $true; value = [boolean]$BackupFailureNotification })
                }
                'BackupPath' {
                    $body.data.Add('backupPath', @{ dirty = $true; value = $BackupPath })
                }
                'BackupStartDateTime' {
                    $body.data.Add('backupStartDateTime', @{ dirty = $true; value = $BackupStartDateTime })
                }
                'ConfigurationSqlBackupTimeoutMinutes' {
                    $body.data.Add('configurationSqlBackupTimeoutMinutes', @{ dirty = $true; value = $ConfigurationSqlBackupTimeoutMinutes })
                }
                'CopyOnlyDatabaseBackup' {
                    $body.data.Add('copyOnlyDatabaseBackup', @{ dirty = $true; value = [boolean]$CopyOnlyDatabaseBackup })
                }
                'EnableDatabaseBackup' {
                    $body.data.Add('enableDatabaseBackup', @{ dirty = $true; value = [boolean]$EnableDatabaseBackup })
                }
                'EnableScheduledBackup' {
                    $body.data.Add('enableScheduledBackup', @{ dirty = $true; value = [boolean]$EnableScheduledBackup })
                }
                'EnableTmsBackup' {
                    $body.data.Add('enableTmsBackup', @{ dirty = $true; value = [boolean]$EnableTmsBackup })
                }
                'EnableWebApplicationBackup' {
                    $body.data.Add('enableWebApplicationBackup', @{ dirty = $true; value = [boolean]$EnableWebApplicationBackup })
                }
                'NumberOfBackupsToKeep' {
                    $body.data.Add('numberOfBackupsToKeep', @{ dirty = $true; value = $NumberOfBackupsToKeep })
                }
                'RepeatDays' {
                    $body.data.Add('repeatDays', @{ dirty = $true; value = $RepeatDays })
                }
                'RepeatHours' {
                    $body.data.Add('repeatHours', @{ dirty = $true; value = $RepeatHours })
                }
                'RepeatMinutes' {
                    $body.data.Add('repeatMinutes', @{ dirty = $true; value = $RepeatMinutes })
                }
                'TmsInstallationPath' {
                    $body.data.Add('tmsInstallationPath', @{ dirty = $true; value = $TmsInstallationPath })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Backup configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssBackupConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.Backup](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.Backup]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
