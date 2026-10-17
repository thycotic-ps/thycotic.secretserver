---
title: Search-TssPlatformConfigurationAudit
parent: Configurations
grand_parent: Commands
---
# Search-TssPlatformConfigurationAudit

## SYNOPSIS
Search the audit records of the Platform integration configuration

## SYNTAX

```
Search-TssPlatformConfigurationAudit [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the audit trail of changes made to the Delinea Platform integration configuration: action, date, user display name and notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformConfigurationAudit -TssSession $session
```

Returns the Platform integration configuration audit records

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssPlatformConfigurationAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssPlatformConfigurationAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssPlatformConfigurationAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssPlatformConfigurationAudit.ps1)
