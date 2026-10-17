---
title: Search-TssEventPipelineAudit
parent: Event Pipelines
grand_parent: Commands
---
# Search-TssEventPipelineAudit

## SYNOPSIS
Search event pipeline and event pipeline policy audit entries

## SYNTAX

```
Search-TssEventPipelineAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the audit trail of event pipelines and event pipeline policies, newest changes included.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelineAudit -TssSession $session
```

Returns all event pipeline and policy audit entries

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipeline.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineAudit.ps1)
