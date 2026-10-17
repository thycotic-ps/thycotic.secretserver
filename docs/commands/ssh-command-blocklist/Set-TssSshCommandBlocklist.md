---
title: Set-TssSshCommandBlocklist
parent: SSH Command Blocklist
grand_parent: Commands
---
# Set-TssSshCommandBlocklist

## SYNOPSIS
Change an SSH command blocklist

## SYNTAX

```
Set-TssSshCommandBlocklist [-TssSession] <Session> -Id <String> [-Active] [-Description <String>]
 [-Name <String>] [-SshCommandIds <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes the SSH command blocklist with the given ID.
Only the parameters you pass are changed.
-SshCommandIds replaces the whole set of commands on the list.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860' -Active
```

Activates the blocklist

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$blocked = Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked
Set-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860' -SshCommandIds $blocked.SshCommandGuid
```

Puts every blocked SSH command on the blocklist

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

### -Id
SSH command blocklist ID (a GUID)

```yaml
Type: String
Parameter Sets: (All)
Aliases: SshCommandBlocklistId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Use -Active to activate the blocklist or -Active:$false to deactivate it

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

### -Description
New description

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

### -Name
New name

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

### -SshCommandIds
SshCommandGuid of each blocked SSH command the list should hold; replaces the current set

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Set-TssSshCommandBlocklist](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Set-TssSshCommandBlocklist)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Set-TssSshCommandBlocklist.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Set-TssSshCommandBlocklist.ps1)
