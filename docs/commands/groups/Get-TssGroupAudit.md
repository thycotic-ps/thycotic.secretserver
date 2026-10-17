---
title: Get-TssGroupAudit
parent: Groups
grand_parent: Commands
---
# Get-TssGroupAudit

## SYNOPSIS
Get the audit records for groups

## SYNTAX

```
Get-TssGroupAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the administration audit records for groups, such as group renames and groups being enabled or disabled.
Each record has the action, notes, date and the user who made the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupAudit -TssSession $session
```

Gets the group audit records

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

### Thycotic.PowerShell.Groups.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupAudit.ps1)
