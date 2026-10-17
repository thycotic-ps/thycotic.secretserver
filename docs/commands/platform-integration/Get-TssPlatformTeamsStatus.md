---
title: Get-TssPlatformTeamsStatus
parent: Platform Integration
grand_parent: Commands
---
# Get-TssPlatformTeamsStatus

## SYNOPSIS
Get the Teams status for Platform data integration

## SYNTAX

```
Get-TssPlatformTeamsStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get whether Teams are enabled on this Secret Server, as Platform data integration reports it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformTeamsStatus -TssSession $session
```

Show whether Teams are enabled

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

### Thycotic.PowerShell.PlatformIntegration.TeamsStatus
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformTeamsStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformTeamsStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformTeamsStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformTeamsStatus.ps1)
