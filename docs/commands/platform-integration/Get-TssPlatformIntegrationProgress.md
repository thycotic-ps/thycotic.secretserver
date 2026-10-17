---
title: Get-TssPlatformIntegrationProgress
parent: Platform Integration
grand_parent: Commands
---
# Get-TssPlatformIntegrationProgress

## SYNOPSIS
Get the progress of each Delinea Platform data integration step

## SYNTAX

### Default (Default)
```
Get-TssPlatformIntegrationProgress [-TssSession] <Session>
 [<CommonParameters>]
```

### ByStepType
```
Get-TssPlatformIntegrationProgress [-TssSession] <Session> [-ByStepType]
 [<CommonParameters>]
```

## DESCRIPTION
Returns one object per step of the Delinea Platform data integration (onboarding) sequence, with its status and start and end dates.
By default steps are identified by number (Step, v1 endpoint).
With -ByStepType steps are identified by name (StepType, v2 endpoint), for example OptIn, SecureAccess, Domains or SyncData.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformIntegrationProgress -TssSession $session
```

Returns the status of each integration step, identified by step number

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformIntegrationProgress -TssSession $session -ByStepType | Where-Object Status -ne 'Complete'
```

Returns the integration steps that are not complete, identified by step name

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

### -ByStepType
Identify the steps by name (StepType) using the v2 endpoint instead of by number

```yaml
Type: SwitchParameter
Parameter Sets: ByStepType
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

### Thycotic.PowerShell.PlatformIntegration.IntegrationStep[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformIntegrationProgress](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformIntegrationProgress)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformIntegrationProgress.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformIntegrationProgress.ps1)
