---
title: Get-TssKeyManagementAudit
parent: Key Management
grand_parent: Commands
---
# Get-TssKeyManagementAudit

## SYNOPSIS
Get the Key Management audit trail

## SYNTAX

### Default (Default)
```
Get-TssKeyManagementAudit [-TssSession] <Session> [-Action <String>] [-SearchTerm <String>]
 [-UserId <Int32>] [<CommonParameters>]
```

### Users
```
Get-TssKeyManagementAudit [-TssSession] <Session> [-Users]
 [<CommonParameters>]
```

### Configuration
```
Get-TssKeyManagementAudit [-TssSession] <Session> [-SearchText <String>] [-Configuration]
 [<CommonParameters>]
```

## DESCRIPTION
By default, gets the master encryption key rotation audit records, filtered by action, user or text.
-Users gets the distinct users that appear in the master encryption key rotation audit.
-Configuration gets the Key Management configuration change audit records.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssKeyManagementAudit -TssSession $session
```

Get the master encryption key rotation audit records

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssKeyManagementAudit -TssSession $session -Users
```

Get the users that appear in the master encryption key rotation audit

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssKeyManagementAudit -TssSession $session -Configuration
```

Get the Key Management configuration change audit records

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

### -Action
Return only rotation audit records with this action

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTerm
Return only rotation audit records that contain this text

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId
Return only rotation audit records of this user id

```yaml
Type: Int32
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Users
Get the distinct users in the master encryption key rotation audit

```yaml
Type: SwitchParameter
Parameter Sets: Users
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Return only configuration audit records that contain this text

```yaml
Type: String
Parameter Sets: Configuration
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Configuration
Get the Key Management configuration change audit records

```yaml
Type: SwitchParameter
Parameter Sets: Configuration
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.KeyManagement.RotationAudit[]
### Thycotic.PowerShell.KeyManagement.AuditUser[]
### Thycotic.PowerShell.KeyManagement.ConfigurationAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementAudit.ps1)
