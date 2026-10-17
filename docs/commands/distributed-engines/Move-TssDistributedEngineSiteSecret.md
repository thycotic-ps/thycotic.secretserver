---
title: Move-TssDistributedEngineSiteSecret
parent: Distributed Engines
grand_parent: Commands
---
# Move-TssDistributedEngineSiteSecret

## SYNOPSIS
Move every secret on a Distributed Engine site to another site

## SYNTAX

```
Move-TssDistributedEngineSiteSecret [-TssSession] <Session> -Id <Int32> [-DisableSite] -NewSiteId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reassigns every secret that uses a site to another site.
With -DisableSite also deactivates the source site and every engine on it.
Returns the source site.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssDistributedEngineSiteSecret -TssSession $session -Id 3 -NewSiteId 4
```

Moves every secret on site 3 to site 4 after confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssDistributedEngineSiteSecret -TssSession $session -Id 3 -NewSiteId 4 -DisableSite -Confirm:$false
```

Moves every secret on site 3 to site 4 and deactivates site 3 and its engines without prompting

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
ID of the site the secrets move off

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SiteId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DisableSite
Also deactivate the source site and its engines

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

### -NewSiteId
ID of the site the secrets move to

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

### Thycotic.PowerShell.DistributedEngines.Site
## NOTES
Requires TssSession object returned by New-TssSession

Moves every secret on the site in one call; moving them back also moves the secrets that were already on the other site, so it asks for confirmation by default.
A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint under a misspelled path (winauthwebsesrvices), so the request fails.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngineSiteSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngineSiteSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngineSiteSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngineSiteSecret.ps1)
