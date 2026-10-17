---
title: Remove-TssProxySshClientOverride
parent: Proxy
grand_parent: Commands
---
# Remove-TssProxySshClientOverride

## SYNOPSIS
Remove an SSH terminal client override

## SYNTAX

```
Remove-TssProxySshClientOverride [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes SSH terminal client overrides by ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssProxySshClientOverride -TssSession $session -Id 4
```

Deletes client override 4

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
Client override ID (ClientOverrideId in Search-TssProxySshClientOverride output)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ClientOverrideId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Remove-TssProxySshClientOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Remove-TssProxySshClientOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Remove-TssProxySshClientOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Remove-TssProxySshClientOverride.ps1)
