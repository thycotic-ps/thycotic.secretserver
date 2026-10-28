---
title: Get-TssSshCommandBlocklist
parent: SSH Command Blocklist
grand_parent: Commands
---
# Get-TssSshCommandBlocklist

## SYNOPSIS
Get an SSH command blocklist

## SYNTAX

```
Get-TssSshCommandBlocklist [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH command blocklist with the given ID and the blocked SSH commands on it.
A blocklist stops the listed commands from running in proxied SSH sessions of secrets whose secret policy applies it.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860'
```

Returns the SSH command blocklist with the given ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' | Get-TssSshCommandBlocklist -TssSession $session
```

Returns every blocklist with "Production" in the name, including the commands on each

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
Type: String[]
Parameter Sets: (All)
Aliases: SshCommandBlocklistId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklist](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklist)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklist.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklist.ps1)
