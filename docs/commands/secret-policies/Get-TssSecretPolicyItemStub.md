# Get-TssSecretPolicyItemStub

## SYNOPSIS
Get empty object for a specific Secret Policy Item

## SYNTAX

```
Get-TssSecretPolicyItemStub [-TssSession] <Session> -ItemName <SecretPolicyItem>
 [-ApplyType <SecretPolicyApplyType>] [<CommonParameters>]
```

## DESCRIPTION
Get empty object for a specific Secret Policy Item, used with creating or updating

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPolicyItemStub -TssSession $session - some test value
```

Add minimum example for each parameter

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

### -ItemName
Secret Policy Item

```yaml
Type: SecretPolicyItem
Parameter Sets: (All)
Aliases:
Accepted values: AutoChangeOnExpiration, HeartBeatEnabled, SiteId, PrivilegedSecretId, PriveledgedSecretId, AssociatedSecretId1, AutoChangeSchedule, PasswordTypeWebScriptId, CheckOutEnabled, CheckOutIntervalMinutes, CheckOutChangePassword, RequireApprovalForAccess, RequireApprovalForAccessForOwnersAndApprovers, RequireApprovalForAccessForEditors, RequireViewComment, IsSessionRecordingEnabled, ViewingPasswordRequiresEdit, ApprovalGroup, AssociatedSecretId2, IsProxyEnabled, EnableSshCommandRestrictions, SshCommandMenuGroups, AllowOwnersUnrestrictedSshCommands, ApprovalWorkflow, EventPipelinePolicy, RunLauncherUsingSSHKey, WebLauncherRequiresIncognitoMode, SshCommandRestrictionType, SshCommandBlocklistOwners, SshCommandBlocklistEditors, SshCommandBlocklistViewers

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplyType
Policy apply type

```yaml
Type: SecretPolicyApplyType
Parameter Sets: (All)
Aliases:
Accepted values: NotSet, Default, Enforced

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

### Thycotic.PowerShell.SecretPolicies.PolicyItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyItemStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyItemStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyItemStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyItemStub.ps1)

