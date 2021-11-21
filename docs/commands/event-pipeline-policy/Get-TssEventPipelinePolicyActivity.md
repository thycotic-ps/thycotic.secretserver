# Get-TssEventPipelinePolicyActivity

## SYNOPSIS
Get all activity for a specific Event Policy run

## SYNTAX

```
Get-TssEventPipelinePolicyActivity [-TssSession] <Session> -PipelineId <Int32> -RunId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Get all activity for a specific Event Policy run

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipeline -TssSession $session -Id 20 | Get-TssEventPipelinePolicyActivity -TssSession $session
```

Output all activity for Event Pipeline ID 20.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelinePolicyActivity -TssSession $session -PipelineId 20 -RunId '6ff82b0a-7ecb-457a-a31b-43d5982570bf'
```

Output the activity for Event Pipeline ID 20 and the noted Run ID GUID.

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
Aliases: EventPipelineId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RunId
Event Pipeline Policy Run ID

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelinePolicyRunId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipelinePolicy.Activity
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Get-TssEventPipelinePolicyActivity](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Get-TssEventPipelinePolicyActivity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyActivity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyActivity.ps1)

