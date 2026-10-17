---
title: Set-TssUserTwoFactor
parent: Bulk User Operations
grand_parent: Commands
---
# Set-TssUserTwoFactor

## SYNOPSIS
Enable, disable, or reset a two-factor method for users in bulk

## SYNTAX

```
Set-TssUserTwoFactor [-TssSession] <Session> -Id <Int32[]> -Action <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enable, disable, or reset one two-factor authentication method (email, RADIUS, TOTP, Duo, FIDO2) for one or more users in one bulk operation.
Reset applies to TOTP and FIDO2 only and clears the user's registration for that method.
The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserTwoFactor -TssSession $session -Id 12, 13 -Action EnableEmail
```

Turn on email two-factor for users 12 and 13

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserTwoFactor -TssSession $session -Id 12 -Action ResetTotp
```

Reset TOTP for user 12 so the user registers a new authenticator

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
IDs of the users to change

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Action
Two-factor change to make: EnableEmail, DisableEmail, EnableRadius, DisableRadius, EnableTotp, DisableTotp, ResetTotp, EnableDuo, DisableDuo, EnableFido2, DisableFido2, ResetFido2

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.BulkOperations.Response
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Set-TssUserTwoFactor](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Set-TssUserTwoFactor)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Set-TssUserTwoFactor.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Set-TssUserTwoFactor.ps1)
