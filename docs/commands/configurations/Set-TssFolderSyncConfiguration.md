---
title: Set-TssFolderSyncConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssFolderSyncConfiguration

## SYNOPSIS
Set the folder synchronization configuration

## SYNTAX

```
Set-TssFolderSyncConfiguration [-TssSession] <Session> [-CompanyId <String>]
 [-DaysToKeepOperationalLogs <Int32>] [-FolderStructure <String>] [-IntegratorCredentials <Int32>]
 [-IntervalDays <Int32>] [-IntervalHours <Int32>] [-IntervalMinutes <Int32>] [-SiteUrl <String>]
 [-SqlCustomView <String>] [-SqlDatabaseName <String>] [-SqlPassword <SecureString>]
 [-SqlServerLocation <String>] [-SqlUsername <String>] [-SyncAllFolders] [-SyncFolderId <Int32>]
 [-SyncMethodType <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set how Secret Server synchronizes folders from ConnectWise.
SyncMethodType None turns synchronization off.
Only the parameters you pass are sent.
Returns the folder synchronization configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderSyncConfiguration -TssSession $session -IntervalHours 4 -IntervalMinutes 0
```

Synchronize folders every four hours

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

### -CompanyId
ConnectWise company Id

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

### -DaysToKeepOperationalLogs
Days to keep the synchronization operational logs

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

### -FolderStructure
Folder structure template, for example $TYPE\$STATUS

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

### -IntegratorCredentials
Id of the secret holding the ConnectWise integrator credentials

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

### -IntervalDays
Days between synchronizations

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

### -IntervalHours
Hours between synchronizations

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

### -IntervalMinutes
Minutes between synchronizations

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

### -SiteUrl
ConnectWise site URL

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

### -SqlCustomView
Custom SQL view to read instead of the standard ConnectWise view (legacy database mode)

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

### -SqlDatabaseName
SQL database name (legacy database mode)

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

### -SqlPassword
SQL password (legacy database mode)

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlServerLocation
SQL server (legacy database mode)

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

### -SqlUsername
SQL user name (legacy database mode)

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

### -SyncAllFolders
Synchronize every folder; pass -SyncAllFolders:$false and -SyncFolderId to synchronize one folder

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

### -SyncFolderId
Folder to synchronize when SyncAllFolders is off

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

### -SyncMethodType
Synchronization method: None, LegacyDatabaseIntegration or ApiIntegration

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

### Thycotic.PowerShell.Configuration.FolderSyncConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderSyncConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderSyncConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderSyncConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderSyncConfiguration.ps1)
