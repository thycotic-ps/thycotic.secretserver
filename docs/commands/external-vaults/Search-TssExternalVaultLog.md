---
title: Search-TssExternalVaultLog
parent: External Vaults
grand_parent: Commands
---
# Search-TssExternalVaultLog

## SYNOPSIS
Search the log of an external vault

## SYNTAX

```
Search-TssExternalVaultLog [-TssSession] <Session> -Id <Int32[]> [-LogLevel <Int32[]>] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the log entries of an external vault (pulls, pushes and their errors), optionally filtered by log level and message text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultLog -TssSession $session -Id 2
```

List the log of external vault 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultLog -TssSession $session -Id 2 -SearchText timeout
```

List the log entries of external vault 2 that mention timeout

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
External vault id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LogLevel
Only return entries with these numeric log levels, as shown in the LogLevel property of the entries

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
Only return entries whose message matches this text

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultLog.ps1)
