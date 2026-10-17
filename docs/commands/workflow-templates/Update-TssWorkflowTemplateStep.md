---
title: Update-TssWorkflowTemplateStep
parent: Workflow Templates
grand_parent: Commands
---
# Update-TssWorkflowTemplateStep

## SYNOPSIS
Update a step of a workflow template

## SYNTAX

```
Update-TssWorkflowTemplateStep [-TssSession] <Session> -Id <Int32> -StepNumber <Int32> [-Name <String>]
 [-Order <Int32>] [-ExpirationMinutes <Int32>] [-NumApprovalsRequired <Int32>] [-ApproveStep <Int32>]
 [-ExpireStep <Int32>] [-GroupId <Int32[]>] [-OwnerReviewer] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
The server replaces the whole step, so the cmdlet first reads the current step (Get-TssWorkflowTemplateStep -StepNumber) and changes only the parameters you pass; a failed read stops the cmdlet before any change.
-GroupId and -OwnerReviewer replace the complete list of approvers; without them the current approvers are kept.
-ApproveStep and -ExpireStep take 0 (none), -1 (next step), -2 (done) or the order of a later step.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 1 -NumApprovalsRequired 2
```

Require two approvals on the first step of workflow template 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 2 -GroupId 7, 8 -OwnerReviewer
```

Make groups 7 and 8 and the secret owner the approvers of the second step of workflow template 4

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -StepNumber
Current order of the step in the template (1 for the first step)

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

### -Name
New step name; must be unique in the template

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

### -Order
New position of the step in the template, 1 to 15

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

### -ExpirationMinutes
Minutes after which the step expires

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

### -NumApprovalsRequired
Number of approvals the step needs

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

### -ApproveStep
Step that follows an approval: 0 none, -1 next step, -2 done, or the order of a later step

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

### -ExpireStep
Step that follows an expiration: 0 none, -1 next step, -2 done, or the order of a later step

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

### -GroupId
IDs of the groups whose members can approve the step; replaces the current approvers

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OwnerReviewer
Make the secret owner an approver of the step; replaces the current approvers

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

### Thycotic.PowerShell.WorkflowTemplates.Step
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStep](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStep)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStep.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStep.ps1)
