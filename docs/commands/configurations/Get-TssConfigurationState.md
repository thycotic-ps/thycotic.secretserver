---
title: Get-TssConfigurationState
parent: Configurations
grand_parent: Commands
---
# Get-TssConfigurationState

## SYNOPSIS
Get the configuration section access of the current user

## SYNTAX

```
Get-TssConfigurationState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns each configuration section id with the access the current user has to it: Admin, View, None or InvalidLicense.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssConfigurationState -TssSession $session).Sections | Where-Object SectionAccess -EQ 'Admin'
```

List the configuration sections the current user can administer

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

### Thycotic.PowerShell.Configuration.State
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationState](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationState.ps1)
