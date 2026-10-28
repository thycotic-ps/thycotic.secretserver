---
title: Update-TssWorkflowTemplateStepList
parent: Workflow Templates
grand_parent: Commands
---
# Update-TssWorkflowTemplateStepList

## SYNOPSIS
Replace all the steps of a workflow template

## SYNTAX

```
Update-TssWorkflowTemplateStepList [-TssSession] <Session> -Id <Int32> -Step <Step[]> [-AllowDelete]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Sends the complete list of steps of the workflow template: a step with WorkflowStepTemplateId 0 is added, a step with an ID is updated, and an existing step that is not in the list is deleted.
The cmdlet first reads the current steps (Get-TssWorkflowTemplateStep) and refuses to send a list that would delete steps unless -AllowDelete is passed; a failed read stops the cmdlet before any change.
Step names must be unique, the Order of the steps must run 1, 2, 3 in list order, and every step needs at least one approver.
Start from Get-TssWorkflowTemplateStep and Get-TssWorkflowTemplateStepStub output.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$steps = Get-TssWorkflowTemplateStep -TssSession $session -Id 4
$steps[0].Configuration.NumApprovalsRequired = 2
Update-TssWorkflowTemplateStepList -TssSession $session -Id 4 -Step $steps
```

Require two approvals on the first step of workflow template 4 and keep the other steps

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$steps = @(Get-TssWorkflowTemplateStep -TssSession $session -Id 4)
Update-TssWorkflowTemplateStepList -TssSession $session -Id 4 -Step $steps[0] -AllowDelete
```

Keep only the first step of workflow template 4 and delete the others

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
Workflow template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: WorkflowTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Step
Complete list of steps, in order

```yaml
Type: Step[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowDelete
Allow the update to delete the existing steps that are not in -Step

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

### Thycotic.PowerShell.WorkflowTemplates.Step[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStepList](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStepList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStepList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStepList.ps1)
