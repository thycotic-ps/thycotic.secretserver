---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderPermissionStub
schema: 2.0.0
title: Get-TssFolderPermissionsStub
---

# Get-TssFolderPermissionsStub

## SYNOPSIS
Get default values for a new folder permission

## SYNTAX

```
Get-TssFolderPermissionsStub [-TssSession] <TssSession> -FolderId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get default values for a new folder permission, a template object

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderPermissionsStub -TssSession $session -FolderId 36
```

Return template object of a new folder permission

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

### -FolderId
Short description for parameter

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssFolderPermission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderPermissionStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderPermissionStub)

