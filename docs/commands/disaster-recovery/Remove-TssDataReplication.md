---
title: Remove-TssDataReplication
parent: Disaster Recovery
grand_parent: Commands
---
# Remove-TssDataReplication

## SYNOPSIS
Remove a Disaster Recovery data replica

## SYNTAX

```
Remove-TssDataReplication [-TssSession] <Session> -Id <String[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a data replica registration from this Secret Server (the Disaster Recovery data source).
The replica no longer receives data from this Secret Server.
Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration.
Requires the Administer Disaster Recovery permission.
An unknown id returns an access denied error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0
```

Remove one data replica

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -WhatIf
```

Show the request that would remove the data replica, without sending it

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
Type: String[]
Parameter Sets: (All)
Aliases: ReplicaId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Remove-TssDataReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Remove-TssDataReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Remove-TssDataReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Remove-TssDataReplication.ps1)
