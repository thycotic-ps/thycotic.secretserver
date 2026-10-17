---
title: Search-TssSshCipher
parent: SSH Ciphers
grand_parent: Commands
---
# Search-TssSshCipher

## SYNOPSIS
Search the algorithms available to SSH cipher suites

## SYNTAX

```
Search-TssSshCipher [-TssSession] <Session> [-AlgorithmType <String[]>] [-SearchTerm <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH algorithms Secret Server offers for an SSH cipher suite, one row per algorithm, with its type and whether it is FIPS compliant.
This is the catalog of algorithms, not the cipher suites themselves (see Search-TssSshCipherSuite).
Without -AlgorithmType it returns all four types, one request per type.
Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipher -TssSession $session
```

Returns every algorithm of every type

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipher -TssSession $session -AlgorithmType KeyExchangeAlgorithm | Where-Object FipsCompliant
```

Returns the FIPS compliant key exchange algorithms

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

### -AlgorithmType
Algorithm types to return: EncryptionAlgorithm, KeyExchangeAlgorithm, MACAlgorithm, PublicKeyAlgorithm.
Default: all four

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @('EncryptionAlgorithm', 'KeyExchangeAlgorithm', 'MACAlgorithm', 'PublicKeyAlgorithm')
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTerm
Return only algorithms whose name matches this text

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

### Thycotic.PowerShell.SshCiphers.SshCipher
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-ciphers/Search-TssSshCipher](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-ciphers/Search-TssSshCipher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-ciphers/Search-TssSshCipher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-ciphers/Search-TssSshCipher.ps1)
