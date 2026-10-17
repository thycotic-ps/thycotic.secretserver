---
title: Get-TssAppClient
parent: App Clients
grand_parent: Commands
---
# Get-TssAppClient

## SYNOPSIS
Get an OAuth app client by ID

## SYNTAX

```
Get-TssAppClient [-TssSession] <Session> -Id <Int32[]> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Get one or more OAuth app clients by ID, including the client ID and the redirect URI.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssAppClient -TssSession $session -Id 2
```

Returns app client 2

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
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive app clients

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AppClients.AppClient
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClient.ps1)
