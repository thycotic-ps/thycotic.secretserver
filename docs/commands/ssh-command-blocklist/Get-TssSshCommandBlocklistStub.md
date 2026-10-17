---
title: Get-TssSshCommandBlocklistStub
parent: SSH Command Blocklist
grand_parent: Commands
---
# Get-TssSshCommandBlocklistStub

## SYNOPSIS
Get a blank SSH command blocklist

## SYNTAX

```
Get-TssSshCommandBlocklistStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns an SSH command blocklist with every field at its default value.
It shows the fields New-TssSshCommandBlocklist sets.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandBlocklistStub -TssSession $session
```

Returns a blank SSH command blocklist

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

### Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklistItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklistStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklistStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklistStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklistStub.ps1)
