---
title: Add-TssTeamSite
parent: Teams
grand_parent: Commands
---
# Add-TssTeamSite

## SYNOPSIS
Add sites to a team

## SYNTAX

```
Add-TssTeamSite [-TssSession] <Session> -Id <Int32> -SiteId <Int32[]> [-Replace] [-ShouldRestrictSites]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add Distributed Engine sites to a team, optionally changing whether the team is restricted to its sites.
The server replaces the team's whole site set with the IDs it is sent.
By default this command first reads the team's current sites (Search-TssTeamSite -IncludeInactive) and sends them together with -SiteId, so existing sites are kept.
Use -Replace to set the team's sites to exactly -SiteId.
When the team is restricted to its sites, at least one site must remain assigned.
Sites cannot be sent in the same call that turns the restriction off.
Returns the team's sites after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamSite -TssSession $session -Id 4 -SiteId 3
```

Adds site 3 to team 4, keeping the sites already assigned

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamSite -TssSession $session -Id 4 -SiteId 1,3 -Replace -ShouldRestrictSites
```

Sets team 4's sites to exactly sites 1 and 3 and restricts the team to them

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

### -SiteId
Site IDs to add to the team

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Replace
Set the team's sites to exactly -SiteId, removing any site not given

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

### -ShouldRestrictSites
Restrict the team to its assigned sites.
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

### Thycotic.PowerShell.Teams.Site[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamSite](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamSite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamSite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamSite.ps1)
