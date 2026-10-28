---
title: Import-TssEventPipelinePolicy
parent: Event Pipeline Policies
grand_parent: Commands
---
# Import-TssEventPipelinePolicy

## SYNOPSIS
Import an event pipeline policy

## SYNTAX

### data
```
Import-TssEventPipelinePolicy [-TssSession] <Session> -Data <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### path
```
Import-TssEventPipelinePolicy [-TssSession] <Session> -Path <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an event pipeline policy, with its pipelines, from an export made by Export-TssEventPipelinePolicy, and returns the new policy.
Pass the export text with Data, or a file holding it with Path.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssEventPipelinePolicy -TssSession $session -Path ./policy-3.json
```

Imports an event pipeline policy from a file

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$export = Export-TssEventPipelinePolicy -TssSession $session -Id 3
Import-TssEventPipelinePolicy -TssSession $session -Data $export
```

Imports a policy from an export held in a variable

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

### -Data
Event pipeline policy export (JSON text from Export-TssEventPipelinePolicy)

```yaml
Type: String
Parameter Sets: data
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path of a file holding an event pipeline policy export

```yaml
Type: String
Parameter Sets: path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipelinePolicy.Policy
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Import-TssEventPipelinePolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Import-TssEventPipelinePolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Import-TssEventPipelinePolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Import-TssEventPipelinePolicy.ps1)
