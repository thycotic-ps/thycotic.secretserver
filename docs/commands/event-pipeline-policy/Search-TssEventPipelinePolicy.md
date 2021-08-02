# Search-TssEventPipelinePolicy

## SYNOPSIS
Get a list of Event Pipeline Policies

## SYNTAX

```
Search-TssEventPipelinePolicy [-TssSession] <Session> [-PipelineId <Int32>] [-PolicyName <String>]
 [-FolderId <Int32>] [-IncludeInactive] [-ExcludeActive] [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of Event Pipeline Policies

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelinePolicy -TssSession $session
```

Return a list of all active Event Pipeline Policies

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelinePolicy -TssSession $session -IncludeInactive
```

Return a list of all active and inactive Event Pipeline Policies

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

### -PipelineId
Event Pipeline ID

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

### -PolicyName
Event Pipeline Policy Name

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

### -FolderId
Folder ID (target of policy)

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

### -IncludeInactive
Include inactive policies

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

### -ExcludeActive
Exclude Active policies

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

### -SortBy
Sort by specific property, default EventPipelinePolicyName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: EventPipelinePolicyName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipelinePolicy.List
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Search-TssEventPipelinePolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Search-TssEventPipelinePolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicy.ps1)

