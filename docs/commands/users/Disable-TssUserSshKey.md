---
title: Disable-TssUserSshKey
parent: Users
grand_parent: Commands
---
# Disable-TssUserSshKey

## SYNOPSIS
Deactivate a user public SSH key

## SYNTAX

```
Disable-TssUserSshKey [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deactivates a user public SSH key by its ID.
Returns the ID of the deactivated key.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Disable-TssUserSshKey -TssSession $session -Id 7
```

Deactivates SSH key 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserSshKey -TssSession $session -IncludeExpired | Where-Object Expired | Disable-TssUserSshKey -TssSession $session
```

Deactivates every expired SSH key

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
ID of the SSH key to deactivate

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Int32
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Disable-TssUserSshKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Disable-TssUserSshKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Disable-TssUserSshKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Disable-TssUserSshKey.ps1)
