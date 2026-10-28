---
title: Search-TssSshCommandMenu
parent: SSH Command Menu
grand_parent: Commands
---
# Search-TssSshCommandMenu

## SYNOPSIS
Search SSH command menus

## SYNTAX

```
Search-TssSshCommandMenu [-TssSession] <Session> [-IncludeDisabled]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH command menus.
Only active menus are returned unless you pass -IncludeDisabled.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandMenu -TssSession $session
```

Returns the active SSH command menus

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandMenu -TssSession $session -IncludeDisabled | Get-TssSshCommandMenu -TssSession $session
```

Returns the full details, commands included, of every menu

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

### -IncludeDisabled
Include inactive menus

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SshCommandMenu.SshCommandMenuItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Search-TssSshCommandMenu](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Search-TssSshCommandMenu)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Search-TssSshCommandMenu.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Search-TssSshCommandMenu.ps1)
