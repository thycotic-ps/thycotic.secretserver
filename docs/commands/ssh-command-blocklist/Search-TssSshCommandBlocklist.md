---
title: Search-TssSshCommandBlocklist
parent: SSH Command Blocklist
grand_parent: Commands
---
# Search-TssSshCommandBlocklist

## SYNOPSIS
Search SSH command blocklists

## SYNTAX

```
Search-TssSshCommandBlocklist [-TssSession] <Session> [-IncludeActive] [-IncludeInactive] [-Name <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH command blocklists that match the filters, without the commands on each (use Get-TssSshCommandBlocklist for those).
Only active blocklists are returned unless you pass -IncludeInactive.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandBlocklist -TssSession $session -IncludeInactive
```

Returns every SSH command blocklist, active or not

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' -IncludeActive
```

Returns the active blocklists with "Production" in the name

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

### -IncludeActive
Include active blocklists.
Active blocklists are included by default; use -IncludeActive:$false to leave them out

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

### -IncludeInactive
Include inactive blocklists.
Defaults to on when you pass -IncludeActive:$false, off otherwise

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

### -Name
Return only blocklists whose name matches this text

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

### Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklistItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Search-TssSshCommandBlocklist](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Search-TssSshCommandBlocklist)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Search-TssSshCommandBlocklist.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Search-TssSshCommandBlocklist.ps1)
