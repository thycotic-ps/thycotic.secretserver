---
title: Set-TssPlatformIntegrationStep
parent: Platform Integration
grand_parent: Commands
---
# Set-TssPlatformIntegrationStep

## SYNOPSIS
Set the status of a Delinea Platform data integration step

## SYNTAX

### Default (Default)
```
Set-TssPlatformIntegrationStep [-TssSession] <Session> -Step <Int32> -Status <String> [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StepType
```
Set-TssPlatformIntegrationStep [-TssSession] <Session> -StepType <String> -Status <String>
 [-StartDate <DateTime>] [-EndDate <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sets the status, and optionally the start and end dates, of one step of the Delinea Platform data integration sequence.
Identify the step by number with -Step (v1 endpoint) or by name with -StepType (v2 endpoint).
Only the parameters you pass are changed.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformIntegrationStep -TssSession $session -StepType SecureAccess -Status Complete -EndDate (Get-Date)
```

Marks the SecureAccess step complete and records now as its end date

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformIntegrationStep -TssSession $session -Step 2 -Status Skipped
```

Marks step 2 as skipped using the v1 endpoint

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

### -Step
Step number to update (v1 endpoint), as returned by Get-TssPlatformIntegrationProgress

```yaml
Type: Int32
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StepType
Step name to update (v2 endpoint), as returned by Get-TssPlatformIntegrationProgress -ByStepType

```yaml
Type: String
Parameter Sets: StepType
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Status to apply to the step

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

### -StartDate
Start date to record for the step

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
End date to record for the step

```yaml
Type: DateTime
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Returns True or False (the success flag of the response).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformIntegrationStep](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformIntegrationStep)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformIntegrationStep.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformIntegrationStep.ps1)
