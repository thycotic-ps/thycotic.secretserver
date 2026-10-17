---
title: Add-TssTeamList
parent: Teams
grand_parent: Commands
---
# Add-TssTeamList

## SYNOPSIS
Add categorized lists to a team

## SYNTAX

```
Add-TssTeamList [-TssSession] <Session> -Id <Int32> -ListId <String[]> [-Replace] [-ShouldRestrictLists]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add categorized lists to a team, optionally changing whether the team is restricted to its lists.
The server replaces the team's whole list set with the IDs it is sent.
By default this command first reads the team's current lists (Search-TssTeamList) and sends them together with -ListId, so existing lists are kept.
Use -Replace to set the team's lists to exactly -ListId.
When the team is restricted to its lists, at least one list must remain assigned.
Returns the lists assigned to the team after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamList -TssSession $session -Id 4 -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Adds the list to team 4, keeping the lists already assigned

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamList -TssSession $session -Id 4 -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e','6c1b0f7e-4f1c-4e0b-9a43-2a8f3c9d1e55' -Replace -ShouldRestrictLists
```

Sets team 4's lists to exactly the two lists and restricts the team to them

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
Team ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TeamId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ListId
Categorized list IDs to add to the team

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CategorizedListId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Replace
Set the team's lists to exactly -ListId, removing any list not given

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

### -ShouldRestrictLists
Restrict the team to its assigned lists.
Leave it out to keep the current setting

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

### Thycotic.PowerShell.Lists.SummaryList[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamList](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamList.ps1)
