---
title: Get-TssGroupStub
parent: Groups
grand_parent: Commands
---
# Get-TssGroupStub

## SYNOPSIS
Get the default values for a new group

## SYNTAX

```
Get-TssGroupStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns a group object filled with the defaults Secret Server uses for a new group.
Its Id is 0.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupStub -TssSession $session
```

Gets the default values for a new group

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

### Thycotic.PowerShell.Groups.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupStub.ps1)
