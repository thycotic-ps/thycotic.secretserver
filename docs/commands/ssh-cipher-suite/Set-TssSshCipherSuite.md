---
title: Set-TssSshCipherSuite
parent: SSH Cipher Suite
grand_parent: Commands
---
# Set-TssSshCipherSuite

## SYNOPSIS
Change an SSH cipher suite

## SYNTAX

```
Set-TssSshCipherSuite [-TssSession] <Session> -Id <String> [-Active] [-Description <String>]
 [-EncryptionAlgorithms <String>] [-KeyExchangeAlgorithms <String>] [-MacAlgorithms <String>] [-Name <String>]
 [-PkAlgorithms <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the SSH cipher suite with the given ID.
Only the parameters you pass are changed.
Algorithm lists are comma-separated algorithm names, as Search-TssSshCipher returns them.
Requires the Administer SSH Cipher Suite role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17' -MacAlgorithms 'hmac-sha2-256,hmac-sha2-512'
```

Limits the suite to two MAC algorithms

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17' -Active:$false
```

Deactivates the suite

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
Type: String
Parameter Sets: (All)
Aliases: SshCipherSuiteConfigurationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Use -Active to activate the cipher suite or -Active:$false to deactivate it

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

### -Description
New description

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

### -EncryptionAlgorithms
Comma-separated encryption algorithms the suite allows

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

### -KeyExchangeAlgorithms
Comma-separated key exchange algorithms the suite allows

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

### -MacAlgorithms
Comma-separated MAC algorithms the suite allows

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

### -Name
New name

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

### -PkAlgorithms
Comma-separated public key algorithms the suite allows

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

### Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Set-TssSshCipherSuite](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Set-TssSshCipherSuite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Set-TssSshCipherSuite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Set-TssSshCipherSuite.ps1)
