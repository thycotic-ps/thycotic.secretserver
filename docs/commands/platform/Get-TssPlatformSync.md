---
title: Get-TssPlatformSync
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformSync

## SYNOPSIS
Get the Platform synchronization status

## SYNTAX

```
Get-TssPlatformSync [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the last and next Platform user and group synchronization: start, end and next run times, error count, groups created, membership changes and the last log entry.
Returns nothing when no synchronization has run.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformSync -TssSession $session | Select-Object StartDateTime, EndDateTime, ErrorCount
```

Show when the last Platform synchronization ran and its error count

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

### Thycotic.PowerShell.Platform.SyncStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformSync.ps1)
