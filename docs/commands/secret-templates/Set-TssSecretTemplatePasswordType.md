---
title: Set-TssSecretTemplatePasswordType
parent: Secret Templates
grand_parent: Commands
---
# Set-TssSecretTemplatePasswordType

## SYNOPSIS
Set the password changing settings of a secret template

## SYNTAX

```
Set-TssSecretTemplatePasswordType [-TssSession] <Session> -Id <Int32> [-DefaultPrivilegedSecretId <Int32>]
 [-EnableHeartbeat] [-EnableRpc] [-FieldMapping <Hashtable>] [-HeartbeatIntervalDays <Int32>]
 [-HeartbeatIntervalHours <Int32>] [-HeartbeatIntervalMinutes <Int32>] [-PasswordTypeId <Int32>]
 [-RpcIntervalDays <Int32>] [-RpcIntervalHours <Int32>] [-RpcIntervalMinutes <Int32>] [-RpcMaxAttempts <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the password type (password changer), remote password changing and heartbeat settings, or field mappings of a secret template.
Only the parameters you pass are changed.
Secret Server saves a heartbeat interval only while heartbeat is enabled on the template, and the response can show the new interval even when it was not saved.
Send -EnableHeartbeat with the interval parameters; the command warns when you do not.
Returns the updated settings.
Get-TssSecretTemplatePasswordType reads them back.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -EnableHeartbeat -HeartbeatIntervalHours 4
```

Enable heartbeat on template 6007 and run it every 4 hours

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -RpcMaxAttempts 5
```

Allow 5 remote password changing attempts for secrets of template 6007

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
Secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DefaultPrivilegedSecretId
Secret ID of the default privileged account used to change passwords

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

### -EnableHeartbeat
Enable heartbeat, or disable it with -EnableHeartbeat:$false

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

### -EnableRpc
Enable remote password changing, or disable it with -EnableRpc:$false

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

### -FieldMapping
Mapping of secret template field IDs (keys) to password type field IDs (values), for example @{ 108 = 32; 109 = 33 }

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatIntervalDays
Days part of the heartbeat interval

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

### -HeartbeatIntervalHours
Hours part of the heartbeat interval

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

### -HeartbeatIntervalMinutes
Minutes part of the heartbeat interval.
Secret Server rejects a total interval under 15 minutes, or under 60 minutes on Secret Server Cloud

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

### -PasswordTypeId
Password type (password changer) ID to assign

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

### -RpcIntervalDays
Days part of the remote password changing retry interval

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

### -RpcIntervalHours
Hours part of the remote password changing retry interval

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

### -RpcIntervalMinutes
Minutes part of the remote password changing retry interval

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

### -RpcMaxAttempts
Maximum number of remote password changing attempts

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

### Thycotic.PowerShell.SecretTemplates.PasswordType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplatePasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplatePasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplatePasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplatePasswordType.ps1)
