---
title: Get-TssEventPipelinePolicyGroupCount
parent: Event Pipeline Policies
grand_parent: Commands
---
# Get-TssEventPipelinePolicyGroupCount

## SYNOPSIS
Get the number of groups an event pipeline policy is assigned to

## SYNTAX

```
Get-TssEventPipelinePolicyGroupCount [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the number of groups an event pipeline policy is assigned to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelinePolicyGroupCount -TssSession $session -Id 4
```

Returns the number of groups event pipeline policy 4 is assigned to

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

### System.Int32
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Get-TssEventPipelinePolicyGroupCount](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Get-TssEventPipelinePolicyGroupCount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyGroupCount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyGroupCount.ps1)
