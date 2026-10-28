---
title: Get-TssTeamStub
parent: Teams
grand_parent: Commands
---
# Get-TssTeamStub

## SYNOPSIS
Get the default values for a new team

## SYNTAX

```
Get-TssTeamStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get a team object filled with the server's default values for a new team.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssTeamStub -TssSession $session
```

Returns the default values for a new team

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

### Thycotic.PowerShell.Teams.Team
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeamStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeamStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeamStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeamStub.ps1)
