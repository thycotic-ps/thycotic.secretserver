---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Invoke-TssSecretGeneratePassword
schema: 2.0.0
title: Invoke-TssSecretGeneratePassword
---

# Invoke-TssSecretGeneratePassword

## SYNOPSIS
Create a new Secret password

## SYNTAX

```
Invoke-TssSecretGeneratePassword [-TssSession] <TssSession> -Id <Int32> -Slug <String> [<CommonParameters>]
```

## DESCRIPTION
Create a new Secret password, based on password rules of the field

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
$newPassword = Invoke-TssSecretGeneratePassword -TssSession $session -Id 25 -Slug 'private-key-passphrase'
Set-TssSecret -TssSession $session -Id 25 -Field 'private-key-passphrase' -Value $newPassword
```

Generating password for Secret ID 25 based on password rules configured for the template, updating password field using Set-TssSecret

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Secret Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Slug
Field slug name

```yaml
Type: String
Parameter Sets: (All)
Aliases: FieldSlug

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Invoke-TssSecretGeneratePassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/Invoke-TssSecretGeneratePassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-SecretGeneratePassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-SecretGeneratePassword.ps1)

