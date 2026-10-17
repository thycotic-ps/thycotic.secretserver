---
title: Get-TssSshCommandItemAudit
parent: SSH Command Item
grand_parent: Commands
---
# Get-TssSshCommandItemAudit

## SYNOPSIS
Get the audit trail of SSH commands, blocklists and menus

## SYNTAX

```
Get-TssSshCommandItemAudit [-TssSession] <Session> [-NameOrNotes <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns one entry per change made to an SSH command, SSH command blocklist or SSH command menu: who made it, when, the action, the commands before and after, and any notes.
ItemType tells which kind of item an entry is about.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandItemAudit -TssSession $session
```

Returns every SSH command, blocklist and menu audit entry

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandItemAudit -TssSession $session -NameOrNotes 'Production'
```

Returns the entries whose item name or notes contain "Production"

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

### -NameOrNotes
Return only entries whose item name or notes match this text

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SshCommandItem.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-item/Get-TssSshCommandItemAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-item/Get-TssSshCommandItemAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-item/Get-TssSshCommandItemAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-item/Get-TssSshCommandItemAudit.ps1)
