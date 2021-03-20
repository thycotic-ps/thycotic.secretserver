---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderStub
schema: 2.0.0
title: Get-TssFolderStub
---

# Get-TssFolderStub

## SYNOPSIS
Get template for new secret folder

## SYNTAX

```
Get-TssFolderStub [-TssSession] <TssSession> [<CommonParameters>]
```

## DESCRIPTION
Get template for new secret folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderStub -TssSession $session
```

Returns folder template as an object

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

### TssFolder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-FolderStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-FolderStub.ps1)

