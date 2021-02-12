---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version:
schema: 2.0.0
title: Get-TssSecretStub
---

# Get-TssSecretStub

## SYNOPSIS
Return template object

## SYNTAX

```
Get-TssSecretStub [-TssSession] <TssSession> -SecretTemplateId <Int32> [-FolderId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Return a template object to be used for create a new secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretStub -TssSession $session -SecretTemplateId 6001
```

Return the Active Directory template as an object

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

### -SecretTemplateId
Secret Template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FolderId
Folder ID, sets the Folder ID property on the output object

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssSecret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS
