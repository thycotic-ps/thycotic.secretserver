---
title: New-TssUserSshKey
parent: Users
grand_parent: Commands
---
# New-TssUserSshKey

## SYNOPSIS
Create an SSH key pair for the current user

## SYNTAX

```
New-TssUserSshKey [-TssSession] <Session> [-Algorithm <String>] -Description <String> -Format <String>
 [-Passphrase <SecureString>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an SSH key pair for the current user, stores the public key and returns the private key as text.
The output is private key material and is returned only once: save it securely.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$privateKey = New-TssUserSshKey -TssSession $session -Description deploy -Format OpenSSH -Algorithm EdDSA
```

Creates an EdDSA key pair in OpenSSH format and keeps the private key in a variable

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

### -Algorithm
Key algorithm: RSA, DSA, ECDSA or EdDSA

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

### -Description
Description of the key

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

### -Format
Private key file format: OpenSSH or PuTTY

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

### -Passphrase
Passphrase that protects the private key

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUserSshKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUserSshKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUserSshKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUserSshKey.ps1)
