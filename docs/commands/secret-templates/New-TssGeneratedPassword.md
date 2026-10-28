---
title: New-TssGeneratedPassword
parent: Secret Templates
grand_parent: Commands
---
# New-TssGeneratedPassword

## SYNOPSIS
Generate a password for a secret template field

## SYNTAX

```
New-TssGeneratedPassword [-TssSession] <Session> -Id <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns a new password that meets the password requirements of a password field on a secret template.
Nothing is saved on the server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssGeneratedPassword -TssSession $session -Id 108
```

Returns a new password for secret template field 108

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSecretTemplate -TssSession $session -Id 6).Fields | Where-Object IsPassword | New-TssGeneratedPassword -TssSession $session
```

Returns a new password for each password field of secret template 6

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
Secret template field ID of a password field

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretTemplateFieldId, SecretFieldId

Required: True
Position: Named
Default value: 0
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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssGeneratedPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssGeneratedPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssGeneratedPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssGeneratedPassword.ps1)
