---
title: Set-TssIncomingDrConfiguration
parent: Disaster Recovery
grand_parent: Commands
---
# Set-TssIncomingDrConfiguration

## SYNOPSIS
Update the Disaster Recovery incoming configuration

## SYNTAX

```
Set-TssIncomingDrConfiguration [-TssSession] <Session> [-DataPackageStoragePath <String>]
 [-DataReplicationEnabled] [-DataSourceCertificatePinningKeyHashSha256 <String>] [-DataSourceKey <String>]
 [-DataSourceUrl <String>] [-ForceLegacyReplication] [-ReplicationIntervalMinutes <Int32>]
 [-UserAccountOption <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the Disaster Recovery settings of this Secret Server as a data replica.
Only the values you pass are changed.
Enabling data replication needs a valid data source URL and data source key (the DataSourceUrl and DataSourceKey of the data source, from Get-TssOutgoingDrConfiguration there).
Changing the data source settings starts a new handshake with the data source.
Enabling replication makes this Secret Server a data replica of the data source.
-DataPackageStoragePath and -ReplicationIntervalMinutes apply to on-premises Secret Server only and are ignored on Secret Server Cloud.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssIncomingDrConfiguration -TssSession $session -ReplicationIntervalMinutes 30
```

Replicate every 30 minutes

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$source = Get-TssOutgoingDrConfiguration -TssSession $sourceSession
Set-TssIncomingDrConfiguration -TssSession $session -DataSourceUrl $source.DataSourceUrl -DataSourceKey $source.DataSourceKey -DataReplicationEnabled
```

Make this Secret Server a data replica of the Secret Server in $sourceSession

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

### -DataPackageStoragePath
Folder path where data packages are stored (on-premises only)

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

### -DataReplicationEnabled
Enable data replication from the data source.
Pass -DataReplicationEnabled:$false to disable it

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

### -DataSourceCertificatePinningKeyHashSha256
SHA-256 hash of the data source certificate public key to pin.
An empty string removes the pin

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

### -DataSourceKey
Public key of the data source, the DataSourceKey shown by Get-TssOutgoingDrConfiguration on the data source

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

### -DataSourceUrl
URL of the Secret Server data source

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

### -ForceLegacyReplication
Use the legacy replication protocol

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

### -ReplicationIntervalMinutes
Minutes between replication runs (on-premises only)

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

### -UserAccountOption
How replicated user accounts are imported: MirrorSource (same state as the data source) or ImportDisabled

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

### Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssIncomingDrConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssIncomingDrConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssIncomingDrConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssIncomingDrConfiguration.ps1)
