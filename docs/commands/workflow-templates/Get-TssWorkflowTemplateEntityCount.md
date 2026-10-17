---
title: Get-TssWorkflowTemplateEntityCount
parent: Workflow Templates
grand_parent: Commands
---
# Get-TssWorkflowTemplateEntityCount

## SYNOPSIS
Get the number of items that use a workflow template

## SYNTAX

```
Get-TssWorkflowTemplateEntityCount [-TssSession] <Session> -Id <Int32[]> [-IncludeAll]
 [<CommonParameters>]
```

## DESCRIPTION
Workflow templates define the approval steps of secret access requests and secret erase requests.
Managing them requires the Administer Workflows permission and a Secret Workflow license.
Returns the number of secrets and folders that use the workflow template, as an integer.
The items themselves are not listed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssWorkflowTemplateEntityCount -TssSession $session -Id 4
```

Count the active items that use workflow template 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssWorkflowTemplate -TssSession $session | ForEach-Object { [pscustomobject]@{ Name = $_.Name; Count = (Get-TssWorkflowTemplateEntityCount -TssSession $session -Id $_.WorkflowTemplateId -IncludeAll) } }
```

List every active workflow template with the number of items that use it

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

### -IncludeAll
Count every item that uses the template, not only the active ones

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Int32
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateEntityCount](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateEntityCount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateEntityCount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateEntityCount.ps1)
