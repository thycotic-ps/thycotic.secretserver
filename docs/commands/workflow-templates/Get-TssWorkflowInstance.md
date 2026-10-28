---
title: Get-TssWorkflowInstance
parent: Workflow Templates
grand_parent: Commands
---
# Get-TssWorkflowInstance

## SYNOPSIS
Get the workflow instances of a workflow template

## SYNTAX

```
Get-TssWorkflowInstance [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Returns the workflow instances (one per request that runs through the template) with their state, current step and times.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssWorkflowInstance -TssSession $session -Id 4
```

Get the workflow instances of workflow template 4

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

### Thycotic.PowerShell.WorkflowTemplates.Instance[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowInstance](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowInstance)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowInstance.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowInstance.ps1)
