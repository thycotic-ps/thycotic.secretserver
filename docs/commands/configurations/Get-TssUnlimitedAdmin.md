---
title: Get-TssUnlimitedAdmin
parent: Configurations
grand_parent: Commands
---
# Get-TssUnlimitedAdmin

## SYNOPSIS
Get the Unlimited Admin Mode state

## SYNTAX

```
Get-TssUnlimitedAdmin [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns whether Unlimited Admin Mode is currently enabled.
Use Enable-TssUnlimitedAdmin and Disable-TssUnlimitedAdmin to change it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUnlimitedAdmin -TssSession $session
```

Returns the current Unlimited Admin Mode state, Enabled is True or False

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
if ((Get-TssUnlimitedAdmin -TssSession $session).Enabled) { Disable-TssUnlimitedAdmin -TssSession $session -Note 'Troubleshooting complete' }
```

Turns Unlimited Admin Mode off only when it is on

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

### Thycotic.PowerShell.Configuration.UnlimitedAdmin
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdmin](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdmin)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdmin.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdmin.ps1)
