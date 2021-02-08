---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder
schema: 2.0.0
title: Get-TssFolder
---

# Get-TssFolder

## SYNOPSIS
Get a folder from Secret Server

## SYNTAX

```
Get-TssFolder [-TssSession] <TssSession> -Id <Int32[]> [-GetChildren] [-IncludeTemplates] [<CommonParameters>]
```

## DESCRIPTION
Get a folder(s) from Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 4
```

Returns folder associated with the Folder ID, 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93 -Recurse
```

Returns folder associated with the Folder ID, 93 and include child folders

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93 -IncludeTemplates
```

Returns folder associated with Folder ID, 93 and include Secret Templates associated with the folder

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
Folder ID to retrieve

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GetChildren
Retrieve all child folders within the requested folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: GetAllChildren

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTemplates
Include allowable Secret Templates of the requested folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: IncludeAssociatedTemplates

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder)

