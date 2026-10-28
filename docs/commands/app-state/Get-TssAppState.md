---
title: Get-TssAppState
parent: App State
grand_parent: Commands
---
# Get-TssAppState

## SYNOPSIS
Get the application state of Secret Server

## SYNTAX

```
Get-TssAppState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the setup state of the Secret Server instance: Normal when it is ready to use, or a state such as CreateInitialUser, DatabaseConnectionError or ScheduledForDeletion.
StatusText carries extra detail about the state.
ProvisionDeletionDateTime is set when the instance is scheduled for deletion.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssAppState -TssSession $session
```

Get the application state

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

### Thycotic.PowerShell.AppState.Status
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/app-state/Get-TssAppState](https://thycotic-ps.github.io/thycotic.secretserver/commands/app-state/Get-TssAppState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-state/Get-TssAppState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-state/Get-TssAppState.ps1)
