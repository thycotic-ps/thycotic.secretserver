---
title: Get-TssDirectoryServiceConfigurationAudit
parent: Directory Services
grand_parent: Commands
---
# Get-TssDirectoryServiceConfigurationAudit

## SYNOPSIS
Get the audit trail of Directory Services configuration changes

## SYNTAX

```
Get-TssDirectoryServiceConfigurationAudit [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the audit records written when the Directory Services configuration changes: date, user, action and notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryServiceConfigurationAudit -TssSession $session | Sort-Object Date -Descending | Select-Object -First 5
```

Show the five most recent Directory Services configuration changes

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceConfigurationAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceConfigurationAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceConfigurationAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceConfigurationAudit.ps1)
