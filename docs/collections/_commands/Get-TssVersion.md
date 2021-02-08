---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic.secretserver.github.io/commands/Get-TssVersion
schema: 2.0.0
title: Get-TssVersion
---

# Get-TssVersion

## SYNOPSIS
Get version of Secret Server

## SYNTAX

```
Get-TssVersion [-TssSession] <TssSession> [<CommonParameters>]
```

## DESCRIPTION
Get the version of Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssVersion -TssSession $session
```

Returns version of Secret Server alpha

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession

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

[https://thycotic.secretserver.github.io/commands/Get-TssVersion](https://thycotic.secretserver.github.io/commands/Get-TssVersion)

