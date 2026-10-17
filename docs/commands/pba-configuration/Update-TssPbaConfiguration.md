---
title: Update-TssPbaConfiguration
parent: Pba Configuration
grand_parent: Commands
---
# Update-TssPbaConfiguration

## SYNOPSIS
Update the Privilege Behavior Analytics (PBA) configuration

## SYNTAX

```
Update-TssPbaConfiguration [-TssSession] <Session> [-ChallengeEnabled] [-ChallengeLockoutIntegratedEnabled]
 [-ChallengeLockoutSamlEnabled] [-Enabled] [-EncryptionEnabled] [-EventDataUploadInterval <Int32>]
 [-EventDataUploadSizeThreshold <Int32>] [-ExternalPbaUrl <String>] [-FileUploadEnabled]
 [-MetadataInterval <Int32>] [-PbaIntegrationKey <SecureString>] [-RespectOwnerEditorRequireApprovalEnabled]
 [-RetentionDays <Int32>] [-SiteId <Int32>] [-StorageDirectoryPath <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates PBA integration settings.
Only the parameters you pass are changed; everything else is left as it is.
RetentionDays, EventDataUploadInterval, EventDataUploadSizeThreshold, EncryptionEnabled and StorageDirectoryPath are applied only when file upload is enabled, either already or by -FileUploadEnabled in the same call.
Otherwise the server ignores them without an error.
On Secret Server Cloud the server ignores FileUploadEnabled, the five file upload settings above, ChallengeLockoutIntegratedEnabled and SiteId without an error, and ignores MetadataInterval while it is 60, the cloud default.
Returns the updated configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssPbaConfiguration -TssSession $session -MetadataInterval 120
```

Sets the metadata sync interval to 120

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssPbaConfiguration -TssSession $session -FileUploadEnabled -StorageDirectoryPath 'D:\PbaData' -RetentionDays 14
```

Turns on file upload of event data, stores it in D:\PbaData and keeps it 14 days

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssPbaConfiguration -TssSession $session -ChallengeEnabled:$false
```

Turns PBA challenges off

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

### -ChallengeEnabled
Enable or disable PBA challenges

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

### -ChallengeLockoutIntegratedEnabled
Enable or disable challenge lockout for integrated Windows logins.
Ignored on Secret Server Cloud

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

### -ChallengeLockoutSamlEnabled
Enable or disable challenge lockout for SAML logins

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

### -Enabled
Enable or disable the PBA integration

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

### -EncryptionEnabled
Enable or disable encryption of uploaded event data.
Applied only when file upload is enabled

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

### -EventDataUploadInterval
Event data upload interval, 2 to 60.
Applied only when file upload is enabled

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

### -EventDataUploadSizeThreshold
Event data upload size threshold, 500 to 1000000.
Applied only when file upload is enabled

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

### -ExternalPbaUrl
URL of the PBA instance

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

### -FileUploadEnabled
Enable or disable file upload of event data.
Ignored on Secret Server Cloud

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

### -MetadataInterval
Metadata sync interval.
On Secret Server Cloud ignored while the current interval is 60, the cloud default

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

### -PbaIntegrationKey
PBA integration key.
Never written to Verbose or WhatIf output

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

### -RespectOwnerEditorRequireApprovalEnabled
Enable or disable respecting owner and editor require-approval settings

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

### -RetentionDays
Days to keep PBA event data, 2 or more.
Applied only when file upload is enabled

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
Id of the site used for PBA.
Ignored on Secret Server Cloud

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

### -StorageDirectoryPath
Directory where PBA event data is stored.
Applied only when file upload is enabled

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

### Thycotic.PowerShell.PbaConfiguration.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Update-TssPbaConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Update-TssPbaConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Update-TssPbaConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Update-TssPbaConfiguration.ps1)
