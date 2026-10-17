---
title: Get-TssSshCommandMenuAudit
parent: SSH Command Menu
grand_parent: Commands
---
# Get-TssSshCommandMenuAudit

## SYNOPSIS
Get the audit trail of SSH command menus

## SYNTAX

```
Get-TssSshCommandMenuAudit [-TssSession] <Session> [-SshCommandMenuName <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns one entry per change made to an SSH command menu: who made it, when, the action, the commands before and after, and any notes.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandMenuAudit -TssSession $session
```

Returns every SSH command menu audit entry

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandMenuAudit -TssSession $session -SshCommandMenuName 'Linux admins'
```

Returns the audit entries for menus named like "Linux admins"

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

### -SshCommandMenuName
Return only entries for menus whose name matches this text

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

### Thycotic.PowerShell.SshCommandMenu.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenuAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenuAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenuAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenuAudit.ps1)
