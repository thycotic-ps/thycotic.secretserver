---
title: Remove-TssPlatformGroup
parent: Platform
grand_parent: Commands
---
# Remove-TssPlatformGroup

## SYNOPSIS
Unlink a Delinea Platform group from Secret Server

## SYNTAX

```
Remove-TssPlatformGroup [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Unlinks a group that was linked from the Delinea Platform.
Secret Server disables the group; the group record and its history are kept.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssPlatformGroup -TssSession $session -Id 12
```

Unlinks the Platform group with Secret Server group ID 12 and returns True on success

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
Secret Server group ID of the linked Platform group

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupId

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Returns True or False per group ID as returned by the server.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Remove-TssPlatformGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Remove-TssPlatformGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Remove-TssPlatformGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Remove-TssPlatformGroup.ps1)
