---
title: Get-TssPlatformConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssPlatformConfiguration

## SYNOPSIS
Get the Delinea Platform configuration

## SYNTAX

```
Get-TssPlatformConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the Delinea Platform integration settings: OpenID Connect client and URLs, Platform tenant and vault Ids, synchronization intervals, audit and inventory forwarding and the login page options.
The server masks the client secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformConfiguration -TssSession $session
```

Show the Delinea Platform integration settings

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

### Thycotic.PowerShell.Configuration.PlatformConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPlatformConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPlatformConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPlatformConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPlatformConfiguration.ps1)
