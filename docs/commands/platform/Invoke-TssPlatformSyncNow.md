---
title: Invoke-TssPlatformSyncNow
parent: Platform
grand_parent: Commands
---
# Invoke-TssPlatformSyncNow

## SYNOPSIS
Start a Platform synchronization now

## SYNTAX

```
Invoke-TssPlatformSyncNow [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Start a synchronization that updates Platform user properties and group memberships in Secret Server.
Returns True when the run was started, not when it finished; follow it with Get-TssPlatformSync.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssPlatformSyncNow -TssSession $session
Get-TssPlatformSync -TssSession $session
```

Start a Platform synchronization and check its status

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

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformSyncNow](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformSyncNow)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformSyncNow.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformSyncNow.ps1)
