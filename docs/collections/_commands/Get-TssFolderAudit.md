---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderAudit
schema: 2.0.0
title: Get-TssFolderAudit
---

# Get-TssFolderAudit

## SYNOPSIS
Get a list of audits

## SYNTAX

```
Get-TssFolderAudit [-TssSession] <TssSession> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a list of audit for Folder ID

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderAudit -TssSession $session -Id 42
```

Gets the audit entries for Folder ID

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
Aliases: FolderId

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

### TssFolderAuditSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-FolderAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-FolderAudit.ps1)

