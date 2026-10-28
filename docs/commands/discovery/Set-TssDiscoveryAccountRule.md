---
title: Set-TssDiscoveryAccountRule
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryAccountRule

## SYNOPSIS
Update a Discovery account rule

## SYNTAX

```
Set-TssDiscoveryAccountRule [-TssSession] <Session> -Id <Int32> [-AccountAlerts]
 [-AccountNameContains <String>] [-ActionCreateSecrets] [-ComputerNameContains <String>]
 [-CurrentPassphrase <SecureString>] [-CurrentPassword <SecureString>] [-CurrentPrivateKey <SecureString>]
 [-DiscoverySourceId <Int32>] [-FilterFields <Object[]>] [-FolderId <Int32>] [-ImportOnlyPolledLastScan]
 [-IncludeChildOUs] [-IsActive] [-MatchingCondition <String>] [-NewPassword <SecureString>]
 [-OperatingSystemContains <String>] [-OrganizationUnitId <Int32>]
 [-PasswordChangingPrivilegedAccountSecretId <Int32[]>] [-PasswordChangingType <String>]
 [-PasswordOption <String>] [-RuleDescription <String>] [-RuleName <String>] [-ScanTemplateId <Int32>]
 [-SecretNamePattern <String>] [-SecretPermissions <String>] [-SecretTemplateId <Int32>] [-SiteId <Int32>]
 [-SubscribedSpecificGroupId <Int32[]>] [-SubscriberType <String>] [-TakeOverAccountType <String>]
 [-TakeOverPasswordTypeId <Int32>] [-TakeoverSecretId <Int32[]>] [-TakeOverThreshold <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates only the fields passed; omitted fields stay unchanged.
Returns the updated rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryAccountRule -TssSession $session -Id 3 -RuleDescription 'Matches local admin accounts'
```

Change the description of Discovery account rule 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryAccountRule -TssSession $session -Id 3 -IsActive:$false
```

Deactivate Discovery account rule 3

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
Discovery account rule id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: RuleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountAlerts
Send an alert to the subscribers when the rule matches new accounts

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

### -AccountNameContains
Only match accounts whose name contains this text

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

### -ActionCreateSecrets
Create secrets for matched accounts.
Requires PasswordOption, SecretPermissions and SiteId

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

### -ComputerNameContains
Only match computers whose name contains this text

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

### -CurrentPassphrase
Passphrase of the current private key, when PasswordOption is PrivateKey

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CurrentPassword
Current password to store in created secrets, when PasswordOption is Current

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CurrentPrivateKey
Current private key to store in created secrets, when PasswordOption is PrivateKey

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiscoverySourceId
Limit the rule to one discovery source

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

### -FilterFields
Dynamic filters for the scan template: objects or hashtables with scanItemFieldId (int) and filterFieldValue (string)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Folder where created secrets go

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

### -ImportOnlyPolledLastScan
Only import accounts found by the last scan

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

### -IncludeChildOUs
Include child organizational units of OrganizationUnitId

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

### -IsActive
Make the rule active

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

### -MatchingCondition
How ComputerNameContains and AccountNameContains combine: And or Or

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

### -NewPassword
New password to set, when PasswordOption is ChangeTo

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OperatingSystemContains
Only match computers whose operating system contains this text

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

### -OrganizationUnitId
Limit the rule to one organizational unit

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

### -PasswordChangingPrivilegedAccountSecretId
Secret ids of the privileged accounts used to change passwords, when PasswordChangingType is PrivilegedAccount

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

### -PasswordChangingType
Credentials used to change passwords: SecretCredentials or PrivilegedAccount

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

### -PasswordOption
What password created secrets get: Current, ChangeTo, Random, PrivateKey or PublicKey

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

### -RuleDescription
Rule description

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

### -RuleName
Rule name

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

### -ScanTemplateId
Scan template the rule applies to

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

### -SecretNamePattern
Pattern used to name created secrets

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

### -SecretPermissions
How created secrets get permissions: InheritPermission or CopyPermission

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
Secret template used for created secrets

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

### -SiteId
Site used for created secrets

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

### -SubscribedSpecificGroupId
Group ids that receive alerts, when SubscriberType is SpecificUsers

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

### -SubscriberType
Who receives alerts: Admins or SpecificUsers

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

### -TakeOverAccountType
Takeover account mode: Single or Multiple

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

### -TakeOverPasswordTypeId
Password type id used for takeover

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

### -TakeoverSecretId
Secret ids of the accounts used for takeover

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

### -TakeOverThreshold
Takeover threshold

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

### Thycotic.PowerShell.Discovery.AccountRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRule.ps1)
