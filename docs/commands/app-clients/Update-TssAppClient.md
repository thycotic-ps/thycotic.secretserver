---
title: Update-TssAppClient
parent: App Clients
grand_parent: Commands
---
# Update-TssAppClient

## SYNOPSIS
Update the redirect URI of an OAuth app client

## SYNTAX

```
Update-TssAppClient [-TssSession] <Session> -Id <Int32> -RedirectUri <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the redirect URI of an existing OAuth app client.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssAppClient -TssSession $session -Id 2 -RedirectUri 'https://app.example.com/signin'
```

Changes the redirect URI of app client 2

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
App client ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RedirectUri
New redirect URI for the app client

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Update-TssAppClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Update-TssAppClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Update-TssAppClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Update-TssAppClient.ps1)
