---
title: Update-TssGroup
parent: Groups
grand_parent: Commands
---
# Update-TssGroup

## SYNOPSIS
Update a group with the full group model

## SYNTAX

```
Update-TssGroup [-TssSession] <Session> -Id <Int32> -Name <String> [-Enabled] [-DomainId <Int32>]
 [-Synchronized] [-SynchronizeNow] [-AdGuid <String>] [-IsPlatform] [-HasGroupOwners] [-OwnerUserId <Int32[]>]
 [-OwnerUserName <String[]>] [-OwnerGroupId <Int32[]>] [-OwnerGroupName <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a group with the PUT endpoint.
Name is required by the API; the other parameters are sent only when you pass them, and omitted settings keep their current values.
Use this cmdlet for directory, Platform and owner settings.
Set-TssGroup changes name, enabled state, owner groups and IP address restrictions with PATCH.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroup -TssSession $session -Id 42 | Update-TssGroup -TssSession $session -Enabled
```

Enables group 42, keeping its current name

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssGroup -TssSession $session -Id 42 -Name 'Help Desk' -HasGroupOwners -OwnerGroupId 7, 9
```

Renames group 42 and makes groups 7 and 9 its only owners

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

### -Id
Group ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Group name.
Required by the API; pass the current name to keep it

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

### -Enabled
Enable the group.
Use -Enabled:$false to disable it

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

### -DomainId
Directory domain ID.
A value above 0 makes this a directory group and also applies Synchronized, SynchronizeNow and AdGuid

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

### -Synchronized
Synchronize the group with its directory domain.
Applied only with DomainId

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

### -SynchronizeNow
Synchronize the group members on save.
Applied only with DomainId

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

### -AdGuid
Directory object GUID, or the Platform group ID with IsPlatform.
Applied only with DomainId or IsPlatform

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

### -IsPlatform
Mark the group as a Delinea Platform group.
Needs AdGuid

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

### -HasGroupOwners
Use specific owners for the group.
With the owner parameters it replaces the current owners; -HasGroupOwners:$false clears them.
Local groups only

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

### -OwnerUserId
User IDs to make owners.
Used with HasGroupOwners

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OwnerUserName
User names to make owners.
Used with HasGroupOwners

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OwnerGroupId
Group IDs to make owners.
Used with HasGroupOwners

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OwnerGroupName
Group names to make owners.
Used with HasGroupOwners

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.Groups.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroup.ps1)
