---
title: Set-TssPlatformTenantCustomization
parent: Platform Integration
grand_parent: Commands
---
# Set-TssPlatformTenantCustomization

## SYNOPSIS
Update the Platform tenant customization

## SYNTAX

```
Set-TssPlatformTenantCustomization [-TssSession] <Session> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Push the tenant customization information of this Secret Server to the Delinea Platform tenant.
Sends no body.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformTenantCustomization -TssSession $session
```

Update the Platform tenant customization

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

### Thycotic.PowerShell.PlatformMigration.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers a generic 500 error with no error code.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformTenantCustomization](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformTenantCustomization)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformTenantCustomization.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformTenantCustomization.ps1)
