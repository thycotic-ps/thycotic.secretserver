---
title: Search-TssExternalVaultSecretLog
parent: External Vaults
grand_parent: Commands
---
# Search-TssExternalVaultSecretLog

## SYNOPSIS
Search the log of an external vault secret

## SYNTAX

```
Search-TssExternalVaultSecretLog [-TssSession] <Session> -Id <Int32[]> [-LogLevel <Int32[]>]
 [-SearchText <String>] [<CommonParameters>]
```

## DESCRIPTION
Search the log entries of an external vault secret, such as push, pull and sync requests and their results.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultSecretLog -TssSession $session -Id 12
```

Get the log entries of external vault secret 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultSecretLog -TssSession $session -Id 12 -SearchText 'Push'
```

Get the log entries of external vault secret 12 that mention Push

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
External vault secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultSecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LogLevel
Only return log entries with these log levels (numeric, as in the LogLevel property of the output)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Filter on log message text

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

### Thycotic.PowerShell.ExternalVaults.Log[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecretLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecretLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecretLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecretLog.ps1)
