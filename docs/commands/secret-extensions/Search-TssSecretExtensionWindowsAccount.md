---
title: Search-TssSecretExtensionWindowsAccount
parent: Secret Extensions
grand_parent: Commands
---
# Search-TssSecretExtensionWindowsAccount

## SYNOPSIS
Search Windows account secrets by computer name

## SYNTAX

```
Search-TssSecretExtensionWindowsAccount [-TssSession] <Session> -ComputerName <String>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Windows account secrets that match a computer name, as the browser extension finds them.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretExtensionWindowsAccount -TssSession $session -ComputerName 'web01'
```

Returns the Windows account secrets for computer web01

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

### -ComputerName
Computer name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretExtensions.Secret[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionWindowsAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionWindowsAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionWindowsAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionWindowsAccount.ps1)
