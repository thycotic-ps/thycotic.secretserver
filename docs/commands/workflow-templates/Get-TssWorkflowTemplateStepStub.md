---
title: Get-TssWorkflowTemplateStepStub
parent: Workflow Templates
grand_parent: Commands
---
# Get-TssWorkflowTemplateStepStub

## SYNOPSIS
Get a workflow template step stub

## SYNTAX

```
Get-TssWorkflowTemplateStepStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Returns a workflow template step with the default values Secret Server uses for a new step: one approval required and one empty approver entry.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssWorkflowTemplateStepStub -TssSession $session
```

Get the default values for a new workflow template step

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.WorkflowTemplates.Step
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateStepStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateStepStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateStepStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateStepStub.ps1)
