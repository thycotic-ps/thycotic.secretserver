---
title: Search-TssAutoExportAudit
parent: Configurations
grand_parent: Commands
---
# Search-TssAutoExportAudit

## SYNOPSIS
Search automatic export configuration audits

## SYNTAX

```
Search-TssAutoExportAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the audit records for changes to the automatic export configuration: action, date, user display name and notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAutoExportAudit -TssSession $session
```

List the automatic export configuration audits

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

### Thycotic.PowerShell.Configuration.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportAudit.ps1)
