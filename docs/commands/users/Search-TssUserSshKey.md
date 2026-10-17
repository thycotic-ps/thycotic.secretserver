---
title: Search-TssUserSshKey
parent: Users
grand_parent: Commands
---
# Search-TssUserSshKey

## SYNOPSIS
List user public SSH keys

## SYNTAX

```
Search-TssUserSshKey [-TssSession] <Session> [-IncludeExpired] [-IncludeInactive] [-SearchText <String>]
 [-UserId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Lists user public SSH keys, active and unexpired by default.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserSshKey -TssSession $session
```

Lists the active, unexpired public SSH keys

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserSshKey -TssSession $session -UserId 42 -IncludeInactive
```

Lists the public SSH keys of user 42, deactivated keys included

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

### -IncludeExpired
Include expired keys

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
Include deactivated keys

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

### -SearchText
Text to match against the key description

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

### -UserId
Only keys of this user

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Users.SshKey[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserSshKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserSshKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserSshKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserSshKey.ps1)
