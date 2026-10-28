---
title: Get-TssWorkflowTemplateStep
parent: Workflow Templates
grand_parent: Commands
---
# Get-TssWorkflowTemplateStep

## SYNOPSIS
Get the steps of a workflow template

## SYNTAX

### Default (Default)
```
Get-TssWorkflowTemplateStep [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Single
```
Get-TssWorkflowTemplateStep [-TssSession] <Session> -Id <Int32[]> -StepNumber <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Returns every step of the workflow template, or one step with -StepNumber.
Each step carries its approvers, the number of approvals required and the steps that follow an approval or an expiration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssWorkflowTemplateStep -TssSession $session -Id 4
```

Get every step of workflow template 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 2).Configuration.ApproverGroups
```

List the approvers of the second step of workflow template 4

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
Type: Int32[]
Parameter Sets: (All)
Aliases: WorkflowTemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -StepNumber
Order of the step in the template (1 for the first step); returns only that step

```yaml
Type: Int32
Parameter Sets: Single
Aliases:

Required: True
Position: Named
Default value: 0
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateStep](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateStep)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateStep.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateStep.ps1)
