---
title: New-TssWorkflowTemplateStep
parent: Workflow Templates
grand_parent: Commands
---
# New-TssWorkflowTemplateStep

## SYNOPSIS
Add a step to a workflow template

## SYNTAX

```
New-TssWorkflowTemplateStep [-TssSession] <Session> -Id <Int32> -Name <String> -Order <Int32>
 [-NumApprovalsRequired <Int32>] [-ApproveStep <Int32>] [-ExpireStep <Int32>] [-GroupId <Int32[]>]
 [-OwnerReviewer] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Adds an approval step to the workflow template and returns the new step ID.
The step needs at least one approver: groups (-GroupId), the secret owner (-OwnerReviewer), or both.
The step name must be unique in the template and -Order (1 to 15) must not be used by another step.
Without an owner approver, -NumApprovalsRequired cannot exceed the number of active users in the groups.
-ApproveStep and -ExpireStep take 0 (none), -1 (next step), -2 (done) or the order of a later step.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssWorkflowTemplateStep -TssSession $session -Id 4 -Name 'Security review' -Order 2 -GroupId 7
```

Add a second step to workflow template 4, approved by a member of group 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssWorkflowTemplateStep -TssSession $session -Id 4 -Name 'Owner sign-off' -Order 3 -ApproveStep -2 -OwnerReviewer
```

Add a final step to workflow template 4 that the secret owner approves

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

### -Name
Step name; must be unique in the template

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

### -Order
Position of the step in the template, 1 to 15

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

### -NumApprovalsRequired
Number of approvals the step needs; default 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApproveStep
Step that follows an approval: 0 none, -1 next step (default), -2 done, or the order of a later step

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireStep
Step that follows an expiration: 0 none (default), -1 next step, -2 done, or the order of a later step

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
IDs of the groups whose members can approve the step

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
Add the secret owner as an approver of the step

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

### System.Int32
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplateStep](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplateStep)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplateStep.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplateStep.ps1)
