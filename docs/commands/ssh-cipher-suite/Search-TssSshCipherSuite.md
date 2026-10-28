---
title: Search-TssSshCipherSuite
parent: SSH Cipher Suite
grand_parent: Commands
---
# Search-TssSshCipherSuite

## SYNOPSIS
Search SSH cipher suites

## SYNTAX

```
Search-TssSshCipherSuite [-TssSession] <Session> [-IncludeActive] [-IncludeInactive] [-SearchTerm <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH cipher suites that match the filters.
Only active cipher suites are returned unless you pass -IncludeInactive.
Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipherSuite -TssSession $session -IncludeInactive
```

Returns every SSH cipher suite, active or not

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCipherSuite -TssSession $session -SearchTerm 'FIPS'
```

Returns the active cipher suites with "FIPS" in the name

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

### -IncludeActive
Include active cipher suites.
Active suites are included by default; use -IncludeActive:$false to leave them out

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

### -IncludeInactive
Include inactive cipher suites.
Defaults to on when you pass -IncludeActive:$false, off otherwise

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

### -SearchTerm
Return only cipher suites whose name matches this text

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

### Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Search-TssSshCipherSuite](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Search-TssSshCipherSuite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Search-TssSshCipherSuite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Search-TssSshCipherSuite.ps1)
