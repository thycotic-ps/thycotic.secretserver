---
title: Search-TssEventPipelinePolicyGroup
parent: Event Pipeline Policies
grand_parent: Commands
---
# Search-TssEventPipelinePolicyGroup

## SYNOPSIS
Get the groups an event pipeline policy is assigned to

## SYNTAX

```
Search-TssEventPipelinePolicyGroup [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the groups an event pipeline policy is assigned to (user and group policies).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelinePolicyGroup -TssSession $session -Id 4
```

Returns the groups event pipeline policy 4 is assigned to

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

### Thycotic.PowerShell.EventPipelinePolicy.Group[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicyGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicyGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicyGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicyGroup.ps1)
