---
title: Get-TssUnlimitedAdminAudit
parent: Configurations
grand_parent: Commands
---
# Get-TssUnlimitedAdminAudit

## SYNOPSIS
Get the Unlimited Admin Mode audit log

## SYNTAX

```
Get-TssUnlimitedAdminAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the audit entries for Unlimited Admin Mode: who enabled or disabled it, when, and the note they gave.
Entries are returned oldest first.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUnlimitedAdminAudit -TssSession $session
```

Returns every Unlimited Admin Mode audit entry, oldest first

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUnlimitedAdminAudit -TssSession $session | Select-Object -Last 5
```

Returns the five most recent Unlimited Admin Mode changes

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

### Thycotic.PowerShell.Configuration.UnlimitedAdminAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdminAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdminAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdminAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdminAudit.ps1)
