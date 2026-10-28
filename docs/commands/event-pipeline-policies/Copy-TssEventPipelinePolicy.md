---
title: Copy-TssEventPipelinePolicy
parent: Event Pipeline Policies
grand_parent: Commands
---
# Copy-TssEventPipelinePolicy

## SYNOPSIS
Copy an event pipeline policy

## SYNTAX

### id
```
Copy-TssEventPipelinePolicy [-TssSession] <Session> -Id <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### data
```
Copy-TssEventPipelinePolicy [-TssSession] <Session> -Data <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of an event pipeline policy, with its pipelines, and returns the new policy.
With Id the policy is exported first (Export-TssEventPipelinePolicy) and the export is duplicated; with Data an export made earlier is duplicated.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Copy-TssEventPipelinePolicy -TssSession $session -Id 3
```

Creates a copy of event pipeline policy 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$export = Export-TssEventPipelinePolicy -TssSession $session -Id 3
Copy-TssEventPipelinePolicy -TssSession $session -Data $export
```

Duplicates a policy from an export

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
Event pipeline policy ID to copy

```yaml
Type: Int32
Parameter Sets: id
Aliases: EventPipelinePolicyId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Data
Event pipeline policy export (JSON text from Export-TssEventPipelinePolicy) to duplicate

```yaml
Type: String
Parameter Sets: data
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

### Thycotic.PowerShell.EventPipelinePolicy.Policy
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Copy-TssEventPipelinePolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Copy-TssEventPipelinePolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Copy-TssEventPipelinePolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Copy-TssEventPipelinePolicy.ps1)
