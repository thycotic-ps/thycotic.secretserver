---
title: New-TssPlatformUsersAndGroups
parent: Platform
grand_parent: Commands
---
# New-TssPlatformUsersAndGroups

## SYNOPSIS
Create Secret Server users and groups for Platform identities

## SYNTAX

```
New-TssPlatformUsersAndGroups [-TssSession] <Session> -PlatformUuid <String> -Name <String>
 [-DisplayName <String>] -EntityType <String> [-ServiceUser] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create local Secret Server users and groups linked to Delinea Platform users and groups.
Pipe in the output of Search-TssPlatformUsersGroups, or pass one identity with the parameters; every identity from the pipeline is sent in one request, and an empty pipeline sends nothing.
Returns the outcome per identity (Data: Type, PlatformUuid, UserId or GroupId, Error) and an Error for the whole request, for example when Platform integration is not enabled.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformUsersGroups -TssSession $session -SearchText 'Eng' -EntityType Groups -ExcludeLinkedLocalEntities | New-TssPlatformUsersAndGroups -TssSession $session
```

Create Secret Server groups for the Platform groups starting with Eng that are not linked yet

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssPlatformUsersAndGroups -TssSession $session -PlatformUuid 0f8c2b9e-1d43-4b7a-9c55-6a0e2f1d7b31 -Name jdoe -DisplayName 'Jane Doe' -EntityType User
```

Create a Secret Server user for one Platform user

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

### -PlatformUuid
Platform user or group Id (GUID); binds PlatformEntityUuid from Search-TssPlatformUsersGroups

```yaml
Type: String
Parameter Sets: (All)
Aliases: PlatformEntityUuid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
User name or group name for the new Secret Server user or group

```yaml
Type: String
Parameter Sets: (All)
Aliases: EntityName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DisplayName
Display name for the new Secret Server user or group

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EntityType
User or Group; DirectoryGroup and XpmGroup, as Search-TssPlatformUsersGroups returns them, are created as groups

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ServiceUser
Create the user as a Platform service user

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Platform.UsersAndGroupsResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformUsersAndGroups](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformUsersAndGroups)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformUsersAndGroups.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformUsersAndGroups.ps1)
