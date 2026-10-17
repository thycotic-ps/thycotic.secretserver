---
title: Get-TssSecretKeyRotationStatus
parent: Configurations
grand_parent: Commands
---
# Get-TssSecretKeyRotationStatus

## SYNOPSIS
Get the status of the secret key rotation

## SYNTAX

```
Get-TssSecretKeyRotationStatus [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns when a Rotate Secret Keys run was last requested and last ran, its last status, and the progress of the current run (secrets processed, total, cancelling).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretKeyRotationStatus -TssSession $session
```

Returns the secret key rotation status

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

### Thycotic.PowerShell.Configuration.SecretKeyRotationStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSecretKeyRotationStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSecretKeyRotationStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSecretKeyRotationStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSecretKeyRotationStatus.ps1)
