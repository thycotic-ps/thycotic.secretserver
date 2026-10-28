---
title: Get-TssEventPipelinePolicyFolderChild
parent: Event Pipeline Policies
grand_parent: Commands
---
# Get-TssEventPipelinePolicyFolderChild

## SYNOPSIS
Get child folder data for a folder of an event pipeline policy

## SYNTAX

```
Get-TssEventPipelinePolicyFolderChild [-TssSession] <Session> -Id <Int32> -FolderId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns, for each child folder of a folder, its child folder count and whether it has an event pipeline policy, as the folder picker of an event pipeline policy shows it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelinePolicyFolderChild -TssSession $session -Id 3 -FolderId 12
```

Returns the child folders of folder 12 for event pipeline policy 3

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
Type: Int32
Parameter Sets: (All)
Aliases: EventPipelinePolicyId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FolderId
Parent folder ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipelinePolicy.FolderChild[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Get-TssEventPipelinePolicyFolderChild](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Get-TssEventPipelinePolicyFolderChild)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyFolderChild.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyFolderChild.ps1)
