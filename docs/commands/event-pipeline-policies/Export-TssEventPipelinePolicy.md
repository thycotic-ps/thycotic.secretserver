---
title: Export-TssEventPipelinePolicy
parent: Event Pipeline Policies
grand_parent: Commands
---
# Export-TssEventPipelinePolicy

## SYNOPSIS
Export an event pipeline policy

## SYNTAX

```
Export-TssEventPipelinePolicy [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns an event pipeline policy and its pipelines as JSON text, for Import-TssEventPipelinePolicy or Copy-TssEventPipelinePolicy.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Export-TssEventPipelinePolicy -TssSession $session -Id 3 | Set-Content -Path ./policy-3.json
```

Exports event pipeline policy 3 to a file

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
Event pipeline policy ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventPipelinePolicyId

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Export-TssEventPipelinePolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Export-TssEventPipelinePolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Export-TssEventPipelinePolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Export-TssEventPipelinePolicy.ps1)
