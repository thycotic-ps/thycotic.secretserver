---
title: Search-TssQuartzJob
parent: Diagnostics
grand_parent: Commands
---
# Search-TssQuartzJob

## SYNOPSIS
List the scheduled background jobs

## SYNTAX

```
Search-TssQuartzJob [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Lists the Quartz scheduler triggers shown under Admin, Diagnostics: one entry per scheduled background job with its trigger state and its previous and next fire times.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssQuartzJob -TssSession $session
```

List the scheduled background jobs

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssQuartzJob -TssSession $session | Where-Object TriggerState -EQ 'ERROR'
```

List the jobs whose trigger is in error

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

### Thycotic.PowerShell.Diagnostics.QuartzJob[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssQuartzJob](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssQuartzJob)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssQuartzJob.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssQuartzJob.ps1)
