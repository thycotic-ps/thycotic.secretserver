---
title: Get-TssConfigurationLoginPolicy
parent: Configurations
grand_parent: Commands
---
# Get-TssConfigurationLoginPolicy

## SYNOPSIS
Get the login policy configuration

## SYNTAX

```
Get-TssConfigurationLoginPolicy [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the login policy banner configuration: whether the banner shows on the login page, whether users must accept it, and the banner text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationLoginPolicy -TssSession $session
```

Get the login policy configuration

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

### Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationLoginPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationLoginPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationLoginPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationLoginPolicy.ps1)
