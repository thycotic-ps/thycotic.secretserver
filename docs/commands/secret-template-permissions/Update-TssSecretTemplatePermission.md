---
title: Update-TssSecretTemplatePermission
parent: Secret Template Permissions
grand_parent: Commands
---
# Update-TssSecretTemplatePermission

## SYNOPSIS
Update the roles that groups hold on secret templates

## SYNTAX

### Default (Default)
```
Update-TssSecretTemplatePermission [-TssSession] <Session> -GroupId <Int32[]> -RoleId <Int32>
 -SecretTemplateId <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Template
```
Update-TssSecretTemplatePermission [-TssSession] <Session> -GroupId <Int32[]> -RoleId <Int32> -Id <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gives groups a secret template role, such as Template Owner or Template Create Secret.
Search-TssSecretTemplatePermissionRole lists the role IDs.
Both forms replace permissions rather than add to them.
With -SecretTemplateId, replaces the secret template permissions of each group with the role on the given templates: the group loses its role on every template not listed.
One request per group; returns the response of each request (GroupId and Permissions).
With -Id, replaces the group permissions of one secret template with the groups given: groups not listed lose their role on the template.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretTemplatePermission -TssSession $session -GroupId 4 -SecretTemplateId 6001, 6007 -RoleId 15
```

Make templates 6001 and 6007 the only templates group 4 can create secrets from (role 15, Template Create Secret)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretTemplatePermission -TssSession $session -Id 6007 -GroupId 4, 5 -RoleId 16
```

Make groups 4 and 5 the only groups with a role on template 6007, as Template Owner (role 16)

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

### -GroupId
Group IDs to give the role to

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleId
Secret template permission role ID, as returned by Search-TssSecretTemplatePermissionRole

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTemplateId
Secret template IDs on which each group gets the role.
Each group keeps no role on other templates

```yaml
Type: Int32[]
Parameter Sets: Default
Aliases: TemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Secret template ID whose group permissions are replaced

```yaml
Type: Int32
Parameter Sets: Template
Aliases: SecretTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission
### Thycotic.PowerShell.SecretTemplates.Result
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Update-TssSecretTemplatePermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Update-TssSecretTemplatePermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Update-TssSecretTemplatePermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Update-TssSecretTemplatePermission.ps1)
