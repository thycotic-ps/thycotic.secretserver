---
title: Get-TssSshCipherSuiteAudit
parent: SSH Cipher Suite
grand_parent: Commands
---
# Get-TssSshCipherSuiteAudit

## SYNOPSIS
Get the audit trail of an SSH cipher suite

## SYNTAX

```
Get-TssSshCipherSuiteAudit [-TssSession] <Session> -Id <String[]> [-SearchTerm <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns one entry per change made to the SSH cipher suite with the given ID: who made it, when, the action, and any notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCipherSuiteAudit -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17'
```

Returns the audit entries for the SSH cipher suite with the given ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipherSuite -TssSession $session | Get-TssSshCipherSuiteAudit -TssSession $session
```

Returns the audit entries for every active SSH cipher suite

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

### -SearchTerm
Return only entries that match this text

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

### Thycotic.PowerShell.SshCipherSuite.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuiteAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuiteAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuiteAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuiteAudit.ps1)
