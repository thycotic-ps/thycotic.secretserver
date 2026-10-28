---
title: Get-TssAppClientStub
parent: App Clients
grand_parent: Commands
---
# Get-TssAppClientStub

## SYNOPSIS
Get the default values for a new OAuth app client

## SYNTAX

```
Get-TssAppClientStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get an OAuth app client object with the default values for a new app client.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssAppClientStub -TssSession $session
```

Returns the default values for a new app client

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AppClients.AppClient
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClientStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClientStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClientStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClientStub.ps1)
