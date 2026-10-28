---
title: Set-TssDataReplication
parent: Disaster Recovery
grand_parent: Commands
---
# Set-TssDataReplication

## SYNOPSIS
Update a Disaster Recovery data replica

## SYNTAX

```
Set-TssDataReplication [-TssSession] <Session> -Id <String> [-FolderIds <Int32[]>] [-IsFoldersBlockList]
 [-Name <String>] [-Status <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes the name, approval status or replicated folders of a data replica registered with this Secret Server.
Only the values you pass are changed.
A replica registers itself as Unapproved; set -Status Approved to start sending it data, or Disabled to stop.
-FolderIds with -IsFoldersBlockList picks which folders are replicated.
Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration.
Requires the Administer Disaster Recovery permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -Status Approved
```

Approve a data replica so it starts receiving data

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -FolderIds 12, 15 -IsFoldersBlockList
```

Replicate every folder except folders 12 and 15 to the data replica

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

### -Id
Data replica id (Guid)

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReplicaId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FolderIds
Folder ids the replica list applies to.
With -IsFoldersBlockList these folders are excluded, otherwise only these folders are replicated

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsFoldersBlockList
Treat -FolderIds as folders to exclude from replication instead of the folders to include

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

### -Name
Display name of the data replica

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

### -Status
Approval status of the data replica: Unapproved, Approved or Disabled

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

### Thycotic.PowerShell.DisasterRecovery.DataReplication
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssDataReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssDataReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssDataReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssDataReplication.ps1)
