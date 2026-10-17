---
title: Search-TssSecretExtensionAd
parent: Secret Extensions
grand_parent: Commands
---
# Search-TssSecretExtensionAd

## SYNOPSIS
Search secrets by Active Directory domain

## SYNTAX

```
Search-TssSecretExtensionAd [-TssSession] <Session> -Domain <String>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secrets that match an Active Directory domain, as the browser extension finds them.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretExtensionAd -TssSession $session -Domain 'corp.example.com'
```

Returns the secrets that match the corp.example.com domain

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

### -Domain
Active Directory domain, for example corp.example.com

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionAd](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionAd)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionAd.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionAd.ps1)
