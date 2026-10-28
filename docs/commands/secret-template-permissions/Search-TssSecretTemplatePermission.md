---
title: Search-TssSecretTemplatePermission
parent: Secret Template Permissions
grand_parent: Commands
---
# Search-TssSecretTemplatePermission

## SYNOPSIS
Search secret template permissions

## SYNTAX

```
Search-TssSecretTemplatePermission [-TssSession] <Session> [-DomainId <Int32>] [-GroupId <Int32>]
 [-SearchText <String>] [-SecretTemplateId <Int32>] [-UserSearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the users and groups that hold a role on secret templates, one record per template and user or group.
Filter by template, group, domain or search text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplatePermission -TssSession $session -SecretTemplateId 6001
```

Get the users and groups that hold a role on template 6001

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

### -DomainId
Return only permissions held by groups of this domain ID

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

### -GroupId
Return only permissions held by this group ID

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

### -SearchText
Text to search for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTemplateId
Return only permissions on this secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretTypeId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserSearchText
Text to search for in user and group names

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.SecretTemplatePermissions.Permission[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermission.ps1)
