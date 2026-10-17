---
title: New-TssWorkflowTemplate
parent: Workflow Templates
grand_parent: Commands
---
# New-TssWorkflowTemplate

## SYNOPSIS
Create a workflow template

## SYNTAX

```
New-TssWorkflowTemplate [-TssSession] <Session> -Name <String> [-Type <WorkflowTypes>] [-Description <String>]
 [-ExpirationMinutes <Int32>] [-ConfigurationJson <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Creates a workflow template and returns its ID.
Secret Server creates the template inactive, with a first step that has no approvers; give it approvers with Update-TssWorkflowTemplateStep -StepNumber 1 -GroupId, add steps with New-TssWorkflowTemplateStep, then activate the template with Update-TssWorkflowTemplate -Active.
Workflow templates cannot be deleted; deactivate one with Update-TssWorkflowTemplate -Active:$false.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssWorkflowTemplate -TssSession $session -Name 'Production access' -Description 'Two approvals for production secrets'
```

Create an access request workflow template and return its ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$id = New-TssWorkflowTemplate -TssSession $session -Name 'Erase review' -Type SecretEraseRequest
Get-TssWorkflowTemplate -TssSession $session -Id $id
```

Create a secret erase request workflow template and get it

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

### -Name
Template name; must be unique

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

### -Type
Workflow type: AccessRequest (default) or SecretEraseRequest

```yaml
Type: WorkflowTypes
Parameter Sets: (All)
Aliases:
Accepted values: AccessRequest, SecretEraseRequest

Required: False
Position: Named
Default value: AccessRequest
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Template description

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

### -ExpirationMinutes
Minutes after which a request that runs through the template expires

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

### -ConfigurationJson
Template configuration, as JSON

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplate.ps1)
