---
title: Search-TssSecretTemplateSimple
parent: Secret Templates
grand_parent: Commands
---
# Search-TssSecretTemplateSimple

## SYNOPSIS
Search the secret templates the current user can use

## SYNTAX

```
Search-TssSecretTemplateSimple [-TssSession] <Session> [-FolderId <Int32>] [-OnlyIncludeCreatable]
 [-OnlyIncludeTemplatesWithUrl] [-PasswordTypeId <Int32[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the ID and name of the active secret templates the current user can see, and whether the user can create secrets from each one.
Basic users can call it, unlike Search-TssSecretTemplate.
Use -OnlyIncludeCreatable with -FolderId to list the templates the user can create secrets from in that folder.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateSimple -TssSession $session -FolderId 12 -OnlyIncludeCreatable
```

List the templates the current user can create secrets from in folder 12

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

### -FolderId
Folder ID used with -OnlyIncludeCreatable

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnlyIncludeCreatable
Return only templates the user can create secrets from in the folder given by -FolderId

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnlyIncludeTemplatesWithUrl
Return only templates that have a URL or URL list field

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordTypeId
Return only templates that use one of these password type IDs

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordTypeIds

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.ListItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateSimple](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateSimple)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateSimple.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateSimple.ps1)
