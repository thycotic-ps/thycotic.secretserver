---
title: New-TssAppClient
parent: App Clients
grand_parent: Commands
---
# New-TssAppClient

## SYNOPSIS
Create a new OAuth app client

## SYNTAX

```
New-TssAppClient [-TssSession] <Session> -RedirectUri <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new OAuth app client with the given redirect URI.
The server generates the client ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssAppClient -TssSession $session -RedirectUri 'https://app.example.com/callback'
```

Creates an app client that redirects to https://app.example.com/callback

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

### -RedirectUri
Redirect URI allowed for the app client

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

### Thycotic.PowerShell.AppClients.AppClient
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/New-TssAppClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/New-TssAppClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/New-TssAppClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/New-TssAppClient.ps1)
