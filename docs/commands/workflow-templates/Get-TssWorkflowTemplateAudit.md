---
title: Get-TssWorkflowTemplateAudit
parent: Workflow Templates
grand_parent: Commands
---
# Get-TssWorkflowTemplateAudit

## SYNOPSIS
Get the audit records of a workflow template

## SYNTAX

```
Get-TssWorkflowTemplateAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Returns the audit records of the workflow template: action, user, date, notes and source machine.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssWorkflowTemplateAudit -TssSession $session -Id 4
```

Get the audit records of workflow template 4

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.WorkflowTemplates.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateAudit.ps1)
