---
title: Update-TssKeyManagement
parent: Key Management
grand_parent: Commands
---
# Update-TssKeyManagement

## SYNOPSIS
Replace the Key Management configuration

## SYNTAX

```
Update-TssKeyManagement [-TssSession] <Session> [-AwsKmsAccessKeyId <String>] [-AwsKmsKeyArn <String>]
 [-AwsKmsSecretAccessKey <SecureString>] [-AzureManagedHsmKeyUrl <String>]
 [-AzureManagedHsmPrincipalId <String>] [-AzureManagedHsmPrincipalSecret <SecureString>]
 [-AzureManagedHsmTenantId <String>] -KeyManagementTypeId <Int32> [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the third-party key management provider that protects the Secret Server master encryption key, and its settings.
The whole configuration is replaced: a setting you do not pass is cleared.
Changing the provider re-protects the master encryption key with the new provider.
Take a database and encryption key backup first.
Requires a license that includes advanced encryption and the permission to edit Key Management.
Refused in read-only mode, and while the last secret key rotation has not finished successfully.
This changes how Secret Server encrypts its data: a wrong or interrupted change can leave Secret Server or its secrets unreadable.
The command writes that warning and asks OK to proceed?
before it sends the request.
-Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$awsSecret = Read-Host -AsSecureString
Update-TssKeyManagement -TssSession $session -KeyManagementTypeId 1 -AwsKmsAccessKeyId AKIAEXAMPLEKEYID -AwsKmsSecretAccessKey $awsSecret -AwsKmsKeyArn arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
```

Protect the master encryption key with an Amazon KMS key

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssKeyManagement -TssSession $session -KeyManagementTypeId 0 -WhatIf
```

Show the request that would remove the third-party key management provider, without sending it

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

### -AwsKmsAccessKeyId
Amazon KMS access key id

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

### -AwsKmsKeyArn
ARN of the Amazon KMS key that protects the master encryption key

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

### -AwsKmsSecretAccessKey
Amazon KMS secret access key

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

### -AzureManagedHsmKeyUrl
URL of the Azure Managed HSM key that protects the master encryption key

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

### -AzureManagedHsmPrincipalId
Azure service principal (application) id used to reach the Managed HSM

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

### -AzureManagedHsmPrincipalSecret
Azure service principal secret

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

### -AzureManagedHsmTenantId
Azure tenant id of the service principal

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

### -KeyManagementTypeId
Key management provider: 0 = None, 1 = Amazon KMS, 2 = Azure Managed HSM

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

### -Force
Skip the OK to proceed?
question, and the confirmation prompt unless -Confirm is passed.
The warning is still written.

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

### Thycotic.PowerShell.KeyManagement.KeyManagement
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Update-TssKeyManagement](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Update-TssKeyManagement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Update-TssKeyManagement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Update-TssKeyManagement.ps1)
