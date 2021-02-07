---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic.secretserver.github.io/commands/Test-TssVersion
schema: 2.0.0
title: Test-TssVersion
---

# Test-TssVersion

## SYNOPSIS
Test Secret Server version

## SYNTAX

```
Test-TssVersion [-TssSession] <TssSession> [<CommonParameters>]
```

## DESCRIPTION
Tests whether Secret Server version returned by Get-TssVersion is the latest

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssVersion -TssSession $session
```

Pulls version of Secret Server and queries for latest version, returning object with details

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssVersion
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic.secretserver.github.io/commands/Test-TssVersion](https://thycotic.secretserver.github.io/commands/Test-TssVersion)

