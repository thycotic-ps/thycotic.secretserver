---
title: Get-TssEventPipelineFilterSetting
parent: Event Pipelines
grand_parent: Commands
---
# Get-TssEventPipelineFilterSetting

## SYNOPSIS
Get the settings of an event pipeline filter

## SYNTAX

```
Get-TssEventPipelineFilterSetting [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the settings a filter definition takes, with their default values.
Setting.SettingName is the key to use in the Settings hashtable of a New-TssEventPipeline or Update-TssEventPipeline filter.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineFilterSetting -TssSession $session -Id 6
```

Returns the settings of filter 6

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineFilterOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineFilterName -eq 'Variable' | Get-TssEventPipelineFilterSetting -TssSession $session
```

Returns the settings of the Variable filter

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
Event pipeline filter ID (EventPipelineFilterId from Get-TssEventPipelineFilterOption)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventPipelineFilterId

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

### Thycotic.PowerShell.EventPipeline.FilterSettingMap[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterSetting.ps1)
