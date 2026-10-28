---
title: Get-TssSecretTemplatePermissionGrouped
parent: Secret Template Permissions
grand_parent: Commands
---
# Get-TssSecretTemplatePermissionGrouped

## SYNOPSIS
Get secret template permissions grouped by template and role

## SYNTAX

```
Get-TssSecretTemplatePermissionGrouped [-TssSession] <Session> [-GroupId <Int32>] [-SecretTemplateId <Int32>]
 [-UserId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns one record per secret template and role, with the users and groups that hold the role in Assignments.
Filter by template, group or user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplatePermissionGrouped -TssSession $session -SecretTemplateId 6001
```

Get the roles on template 6001 and who holds each one

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

### -SecretTemplateId
Return only permissions on this secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId
Return only permissions held by this user ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplatePermissions.Grouped[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped.ps1)
