---
title: Get-TssSshCipherSuite
parent: SSH Cipher Suite
grand_parent: Commands
---
# Get-TssSshCipherSuite

## SYNOPSIS
Get an SSH cipher suite

## SYNTAX

```
Get-TssSshCipherSuite [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH cipher suite with the given ID: the encryption, key exchange, MAC and public key algorithms it allows, and which of them are FIPS compliant.
Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17'
```

Returns the SSH cipher suite with the given ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipherSuite -TssSession $session | Get-TssSshCipherSuite -TssSession $session | Select-Object Name, EncryptionAlgorithms
```

Lists the encryption algorithms each active SSH cipher suite allows

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
SSH cipher suite ID (a GUID)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: SshCipherSuiteConfigurationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SshCipherSuite.SshCipherSuite
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuite](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuite.ps1)
