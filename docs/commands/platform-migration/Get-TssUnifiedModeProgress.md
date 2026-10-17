---
title: Get-TssUnifiedModeProgress
parent: Platform Migration
grand_parent: Commands
---
# Get-TssUnifiedModeProgress

## SYNOPSIS
Get the progress of enabling Platform unified mode

## SYNTAX

```
Get-TssUnifiedModeProgress [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the progress of enabling unified mode: status, whether it is running or stale, and how many users had their permissions refreshed or failed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUnifiedModeProgress -TssSession $session
```

Show the unified mode progress

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

### Thycotic.PowerShell.PlatformMigration.UnifiedModeProgress
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssUnifiedModeProgress](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssUnifiedModeProgress)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssUnifiedModeProgress.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssUnifiedModeProgress.ps1)
