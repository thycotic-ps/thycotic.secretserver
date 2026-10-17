---
title: Search-TssAutoExportLog
parent: Configurations
grand_parent: Commands
---
# Search-TssAutoExportLog

## SYNOPSIS
Search automatic export logs

## SYNTAX

```
Search-TssAutoExportLog [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the automatic export run log: export date, whether the run succeeded, and notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAutoExportLog -TssSession $session | Where-Object { -not $_.Success }
```

List the automatic export runs that failed

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

### Thycotic.PowerShell.Configuration.AutoExportLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportLog.ps1)
