# Reset-TssUserPassword

## SYNOPSIS
Reset a User's password

## SYNTAX

```
Reset-TssUserPassword [-TssSession] <Session> -Id <Int32[]> -Password <SecureString> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Reset a User's password

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Reset-TssUserPassword -TssSession $session -Id 4
```

Add minimum example for each parameter

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
User ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Password
New password for the user

```yaml
Type: SecureString
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserPassword.ps1)

