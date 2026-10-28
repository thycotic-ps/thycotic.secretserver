---
title: Get-TssMekRotationInfo
parent: Key Management
grand_parent: Commands
---
# Get-TssMekRotationInfo

## SYNOPSIS
Get the master encryption key rotation status

## SYNTAX

```
Get-TssMekRotationInfo [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the status of the master encryption key rotation: process state, items left to rotate, last start and end dates, and whether a rotation or a retry can be requested now.
RotationInfo holds the detailed status (Status, StartedDateUtc, LastEndDateUtc, StatusUpdatedDateUtc).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMekRotationInfo -TssSession $session
```

Get the master encryption key rotation status

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssMekRotationInfo -TssSession $session).RotationInfo.Status
```

Show the detailed status of the last rotation

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

### Thycotic.PowerShell.KeyManagement.MekRotation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssMekRotationInfo](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssMekRotationInfo)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssMekRotationInfo.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssMekRotationInfo.ps1)
