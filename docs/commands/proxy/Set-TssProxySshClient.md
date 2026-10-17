---
title: Set-TssProxySshClient
parent: Proxy
grand_parent: Commands
---
# Set-TssProxySshClient

## SYNOPSIS
Set the allow or block list type of an SSH terminal client

## SYNTAX

```
Set-TssProxySshClient [-TssSession] <Session> -Id <Int32> -TerminalClientType <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Moves an SSH terminal client to the allow list or block list, or back to Unknown.
Returns True when the change is saved.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxySshClient -TssSession $session -Id 12 -TerminalClientType BlockList
```

Blocks SSH terminal client 12

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
SSH terminal client ID (ClientId in Search-TssProxySshClient output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ClientId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TerminalClientType
Allow list, block list, or Unknown to remove the client from both

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClient.ps1)
