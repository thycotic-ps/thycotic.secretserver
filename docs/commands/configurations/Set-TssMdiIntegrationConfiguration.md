---
title: Set-TssMdiIntegrationConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssMdiIntegrationConfiguration

## SYNOPSIS
Set the MDI integration configuration

## SYNTAX

```
Set-TssMdiIntegrationConfiguration [-TssSession] <Session> [-Enabled] [-SynchronizationIntervalHours <Int32>]
 [-TenantId <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Turn the Microsoft Defender for Identity (MDI) integration on or off, or change its Azure tenant or synchronization interval.
The first enable needs the admin consent grant from the authorize URL in the web UI; this cmdlet cannot grant it.
Only the parameters you pass are sent.
Returns the MDI integration configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssMdiIntegrationConfiguration -TssSession $session -SynchronizationIntervalHours 8
```

Synchronize MDI every eight hours

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

### -Enabled
Turn the MDI integration on; pass -Enabled:$false to turn it off

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

### -SynchronizationIntervalHours
Hours between MDI synchronizations

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

### -TenantId
Azure tenant Id

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

### Thycotic.PowerShell.Configuration.MdiIntegrationConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssMdiIntegrationConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssMdiIntegrationConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssMdiIntegrationConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssMdiIntegrationConfiguration.ps1)
