# Set-TssSecretPolicy

## SYNOPSIS
Set a Secret Policy property

## SYNTAX

### policy (Default)
```
Set-TssSecretPolicy [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>] [-Active]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### item
```
Set-TssSecretPolicy [-TssSession] <Session> -Id <Int32> [-ItemName <SecretPolicyItem>]
 [-ItemType <SecretPolicyValueType>] [-ItemApplyType <SecretPolicyApplyType>] [-ItemValue <Object>]
 [-UserGroupMap <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set a Secret Policy property

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential ssCred
Set-TssSecretPolicy -TssSession $session -Id 52 -Active:$false
```

Set Secret Policy ID 52 to inactive, changing Active property to false

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential ssCred
Set-TssSecretPolicy -TssSession $session -Id 52 -Active -Name 'Set Auto Change Enabled'
```

Set Secret Policy ID 52 to active and change the name

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
Secret Policy ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretPolicyId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Secret Policy Name

```yaml
Type: String
Parameter Sets: policy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Secret Policy Description

```yaml
Type: String
Parameter Sets: policy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Secret Policy Active or Inactive

```yaml
Type: SwitchParameter
Parameter Sets: policy
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemName
Secret Policy Item Name

```yaml
Type: SecretPolicyItem
Parameter Sets: item
Aliases:
Accepted values: AutoChangeOnExpiration, HeartBeatEnabled, SiteId, PrivilegedSecretId, AssociatedSecretId1, AutoChangeSchedule, PasswordTypeWebScriptId, CheckOutEnabled, CheckOutIntervalMinutes, CheckOutChangePassword, RequireApprovalForAccess, RequireApprovalForAccessForOwnersAndApprovers, RequireApprovalForAccessForEditors, RequireViewComment, IsSessionRecordingEnabled, HideLauncherPassword, ApprovalGroup, AssociatedSecretId2, IsProxyEnabled, EnableSshCommandRestrictions, SshCommandMenuGroups, AllowOwnersUnrestrictedSshCommands, ApprovalWorkflow, EventPipelinePolicy, RunLauncherUsingSSHKey, WebLauncherRequiresIncognitoMode, SshCommandRestrictionType, SshCommandBlocklistOwners, SshCommandBlocklistEditors, SshCommandBlocklistViewers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemType
Secret Policy Item Type

```yaml
Type: SecretPolicyValueType
Parameter Sets: item
Aliases:
Accepted values: Bool, Int, SecretId, Group, Schedule, SshMenuGroup, SshBlocklist

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemApplyType
Secret Policy Item Apply Type (NotSet, Default, Enforced)

```yaml
Type: SecretPolicyApplyType
Parameter Sets: item
Aliases:
Accepted values: NotSet, Default, Enforced

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemValue
Secret Policy Item Value (based on ItemType what object you have to pass in)

```yaml
Type: Object
Parameter Sets: item
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserGroupMap
User and Group Mapping, hashtable of UserGroupId and UserGroupMapType (User or Group)

```yaml
Type: Object
Parameter Sets: item
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1)

