# Search-TssWorkflowTemplate

## SYNOPSIS
Search Workflow Templates

## SYNTAX

```
Search-TssWorkflowTemplate [-TssSession] <Session> [-IncludeInactive] [-Type <WorkflowTypes>]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search Workflow Templates

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssWorkflowTemplate -TssSession $session -IncludeInactive
```

Search Workflow Templates and return those that are inactive in the results

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

### -IncludeInactive
Include inactive workflows

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

### -Type
Workflow Type (AccessRequest, SecretEraseRequest)

```yaml
Type: WorkflowTypes
Parameter Sets: (All)
Aliases:
Accepted values: AccessRequest, SecretEraseRequest

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Name
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.WorkflowTemplates.Detail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflows/Search-TssWorkflowTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflows/Search-TssWorkflowTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-TssWorkflowTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-TssWorkflowTemplate.ps1)

