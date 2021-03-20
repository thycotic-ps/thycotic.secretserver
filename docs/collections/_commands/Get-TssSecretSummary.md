---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretSummary
schema: 2.0.0
title: Get-TssSecretSummary
---

# Get-TssSecretSummary

## SYNOPSIS
Get the summary of a secret

## SYNTAX

```
Get-TssSecretSummary [-TssSession] <TssSession> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get the summary of a secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretSummary -TssSession $session -Id 42
```

Returns the summary information of Secret ID 42

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Short description for parameter

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

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

### TssSecretSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretSummary](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretSummary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretSummary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretSummary.ps1)

