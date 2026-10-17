---
title: Get-TssDrIntegrityCheck
parent: Disaster Recovery
grand_parent: Commands
---
# Get-TssDrIntegrityCheck

## SYNOPSIS
Run a Disaster Recovery data integrity check

## SYNTAX

```
Get-TssDrIntegrityCheck [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Builds a Disaster Recovery replication package on this Secret Server and checks it for errors, without sending it to any replica.
The output lists the entity types checked, the errors and the warnings found.
Success is True when no errors were found.
Requires the Administer Disaster Recovery permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDrIntegrityCheck -TssSession $session
```

Run the integrity check

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssDrIntegrityCheck -TssSession $session).Errors
```

Show only the errors the integrity check found

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

### Thycotic.PowerShell.DisasterRecovery.DrIntegrityCheck
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDrIntegrityCheck](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDrIntegrityCheck)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDrIntegrityCheck.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDrIntegrityCheck.ps1)
