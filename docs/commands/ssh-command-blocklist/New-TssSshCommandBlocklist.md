---
title: New-TssSshCommandBlocklist
parent: SSH Command Blocklist
grand_parent: Commands
---
# New-TssSshCommandBlocklist

## SYNOPSIS
Create an SSH command blocklist

## SYNTAX

```
New-TssSshCommandBlocklist [-TssSession] <Session> [-Active] [-Description <String>] -Name <String>
 -SshCommandIds <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an SSH command blocklist from existing blocked SSH commands.
Apply the blocklist to proxied SSH sessions through a secret policy.
Secret Server has no REST endpoint to delete a blocklist; deactivate one with Set-TssSshCommandBlocklist -Active:$false.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$blocked = Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked
New-TssSshCommandBlocklist -TssSession $session -Name 'Production' -SshCommandIds $blocked.SshCommandGuid -Active
```

Creates an active blocklist holding every blocked SSH command

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSshCommandBlocklist -TssSession $session -Name 'No reboot' -SshCommandIds '9d47e2b1-5c03-4f8e-b6a2-1e7c0d93a4f5' -Description 'Blocks reboot'
```

Creates an inactive blocklist with one blocked command

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

### -Active
Create the blocklist as active.
Without -Active the blocklist is created inactive

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
Description of the blocklist

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
Name of the blocklist, unique among blocklists

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshCommandIds
SshCommandGuid of each blocked SSH command to put on the list (at least one)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/New-TssSshCommandBlocklist](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/New-TssSshCommandBlocklist)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/New-TssSshCommandBlocklist.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/New-TssSshCommandBlocklist.ps1)
