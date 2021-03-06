# Search-TssWorkflowTemplate

## SYNOPSIS
Search Workflow Templates

## SYNTAX

```
Search-TssWorkflowTemplate [-TssSession] <TssSession> [-IncludeInactive] [-Type <String>] [-SortBy <String>]
 [<CommonParameters>]
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
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
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
Workflow Type, default to AccessRequest (only type available at this time)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: AccessRequest
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

### TssWorkflowTemplateDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/workflows/Search-TssWorkflowTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/workflows/Search-TssWorkflowTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-WorkflowTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-WorkflowTemplate.ps1)

