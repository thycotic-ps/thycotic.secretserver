---
title: Get-TssSystemLogConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssSystemLogConfiguration

## SYNOPSIS
Get the system log configuration

## SYNTAX

```
Get-TssSystemLogConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns whether the system log is enabled, the maximum number of entries it keeps, whether administrators are notified when it is shrunk and whether log files can be viewed online.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSystemLogConfiguration -TssSession $session
```

Returns the system log configuration

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

### Thycotic.PowerShell.Configuration.SystemLogConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSystemLogConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSystemLogConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSystemLogConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSystemLogConfiguration.ps1)
