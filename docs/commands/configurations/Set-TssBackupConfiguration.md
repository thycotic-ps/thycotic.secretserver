---
title: Set-TssBackupConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssBackupConfiguration

## SYNOPSIS
Set the Secret Server backup configuration

## SYNTAX

```
Set-TssBackupConfiguration [-TssSession] <Session> [-BackupDatabasePath <String>] [-BackupFailureNotification]
 [-BackupPath <String>] [-BackupStartDateTime <DateTime>] [-ConfigurationSqlBackupTimeoutMinutes <Int32>]
 [-CopyOnlyDatabaseBackup] [-EnableDatabaseBackup] [-EnableScheduledBackup] [-EnableTmsBackup]
 [-EnableWebApplicationBackup] [-NumberOfBackupsToKeep <Int32>] [-RepeatDays <Int32>] [-RepeatHours <Int32>]
 [-RepeatMinutes <Int32>] [-TmsInstallationPath <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the backup configuration: web application and database backup folders, the backup schedule, and how many backups to keep.
Returns the updated configuration.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Name:$false turns a setting off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssBackupConfiguration -TssSession $session -EnableDatabaseBackup -BackupDatabasePath 'D:\Backup\SecretServer' -NumberOfBackupsToKeep 7
```

Back up the database to D:\Backup\SecretServer and keep 7 backups

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssBackupConfiguration -TssSession $session -EnableScheduledBackup:$false
```

Turn off scheduled backups

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for authentication

```yaml
Type: Session
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -BackupDatabasePath
Folder the database backup is written to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupFailureNotification
Send a notification when a backup fails

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupPath
Folder the web application backup is written to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupStartDateTime
Date and time the backup schedule starts

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigurationSqlBackupTimeoutMinutes
Minutes to wait for the database backup before it times out

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyOnlyDatabaseBackup
Take copy-only database backups, which leave the SQL Server backup chain unchanged

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableDatabaseBackup
Back up the database

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableScheduledBackup
Run backups on a schedule

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableTmsBackup
Back up the TMS installation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableWebApplicationBackup
Back up the web application files

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NumberOfBackupsToKeep
Number of backups to keep

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatDays
Days between scheduled backups

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatHours
Hours between scheduled backups

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatMinutes
Minutes between scheduled backups

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TmsInstallationPath
TMS installation folder

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.Backup
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud manages its own backups and can reject this request.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssBackupConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssBackupConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssBackupConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssBackupConfiguration.ps1)
