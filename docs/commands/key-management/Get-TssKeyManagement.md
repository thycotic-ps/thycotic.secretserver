---
title: Get-TssKeyManagement
parent: Key Management
grand_parent: Commands
---
# Get-TssKeyManagement

## SYNOPSIS
Get the Key Management configuration

## SYNTAX

```
Get-TssKeyManagement [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the third-party key management provider that protects the Secret Server master encryption key (None, Amazon KMS or Azure Managed HSM) and its settings.
Secret values are never returned: AwsKmsSecretAccessKey and AzureManagedHsmPrincipalSecret are always empty.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssKeyManagement -TssSession $session
```

Get the Key Management configuration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssKeyManagement -TssSession $session).KeyManagementTypeName
```

Show which key management provider is in use

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.KeyManagement.KeyManagement
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagement](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagement.ps1)
