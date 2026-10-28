---
title: Get-TssMdiIntegrationConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssMdiIntegrationConfiguration

## SYNOPSIS
Get the MDI integration configuration

## SYNTAX

```
Get-TssMdiIntegrationConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the Microsoft Defender for Identity (MDI) integration configuration: whether it is enabled, the Azure tenant, the synchronization interval, the last synchronization times, the consent URL and the actions the caller may take.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMdiIntegrationConfiguration -TssSession $session
```

Show the MDI integration configuration

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

### Thycotic.PowerShell.Configuration.MdiIntegrationConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssMdiIntegrationConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssMdiIntegrationConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssMdiIntegrationConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssMdiIntegrationConfiguration.ps1)
