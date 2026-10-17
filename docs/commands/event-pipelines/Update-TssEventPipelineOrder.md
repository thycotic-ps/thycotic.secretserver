---
title: Update-TssEventPipelineOrder
parent: Event Pipelines
grand_parent: Commands
---
# Update-TssEventPipelineOrder

## SYNOPSIS
Move an event pipeline within its event pipeline policy

## SYNTAX

```
Update-TssEventPipelineOrder [-TssSession] <Session> -Id <Int32> -EventPipelinePolicyId <Int32>
 -SortOrder <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Moves an event pipeline to a new position in an event pipeline policy and returns the policy pipeline order after the move.
Positions start at 1.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssEventPipelineOrder -TssSession $session -Id 12 -EventPipelinePolicyId 3 -SortOrder 1
```

Moves pipeline 12 to the first position in policy 3

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
Event pipeline ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: EventPipelineId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EventPipelinePolicyId
Event pipeline policy the pipeline belongs to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PolicyId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortOrder
New position of the pipeline in the policy, starting at 1

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

### Thycotic.PowerShell.EventPipeline.PolicyMap[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipelineOrder](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipelineOrder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipelineOrder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipelineOrder.ps1)
