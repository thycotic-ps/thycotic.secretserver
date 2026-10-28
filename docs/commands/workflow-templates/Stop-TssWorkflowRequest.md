---
title: Stop-TssWorkflowRequest
parent: Workflow Templates
grand_parent: Commands
---
# Stop-TssWorkflowRequest

## SYNOPSIS
Cancel the active requests of a workflow template

## SYNTAX

```
Stop-TssWorkflowRequest [-TssSession] <Session> -Id <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Cancels every active request that runs through the workflow template and returns the server confirmation message.
A template without active requests succeeds without changes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Stop-TssWorkflowRequest -TssSession $session -Id 4
```

Cancel every active request of workflow template 4

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Stop-TssWorkflowRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Stop-TssWorkflowRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Stop-TssWorkflowRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Stop-TssWorkflowRequest.ps1)
