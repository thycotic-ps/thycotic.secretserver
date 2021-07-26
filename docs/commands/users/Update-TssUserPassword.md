# Update-TssUserPassword

## SYNOPSIS
Update current User's password

## SYNTAX

```
Update-TssUserPassword [-TssSession] <Session> [-Current] <SecureString> [-New] <SecureString> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update current User's password.
Successful update of password will expire the current session.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssUserPassword -TssSession $session -Current $ssCred.Password -New (ConvertTo-SecureString 'P@ssword$h1p@lw@y$')
```

Updates the user's password for the current session

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

### -Current
Current password

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -New
New password to update

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUserPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUserPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUserPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUserPassword.ps1)

