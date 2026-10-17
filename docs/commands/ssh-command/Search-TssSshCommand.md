---
title: Search-TssSshCommand
parent: SSH Command
grand_parent: Commands
---
# Search-TssSshCommand

## SYNOPSIS
Search SSH commands

## SYNTAX

```
Search-TssSshCommand [-TssSession] <Session> [-CommandPermissionType <String>] [-NameOrCommand <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH commands that match the filters.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommand -TssSession $session
```

Returns every SSH command

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked -NameOrCommand 'rm'
```

Returns the blocked commands whose name or text contains "rm"

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

### -CommandPermissionType
Return only Allowed or only Blocked commands

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

### -NameOrCommand
Return only commands whose name or command text matches this text

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

### Thycotic.PowerShell.SshCommand.SshCommand[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Search-TssSshCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Search-TssSshCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Search-TssSshCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Search-TssSshCommand.ps1)
