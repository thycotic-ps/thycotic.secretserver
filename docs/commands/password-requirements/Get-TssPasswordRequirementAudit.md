---
title: Get-TssPasswordRequirementAudit
parent: Password Requirements
grand_parent: Commands
---
# Get-TssPasswordRequirementAudit

## SYNOPSIS
Get audit entries for a password requirement

## SYNTAX

```
Get-TssPasswordRequirementAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the audit records for the given password requirement.
Creating a password requirement records a Create entry, and setting rules or password dictionaries at creation adds Edit entries; the built-in password requirement has no records until it is changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordRequirementAudit -TssSession $session -Id 4
```

Returns the audit records for password requirement ID 4

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
Password requirement ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordRequirementId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PasswordRequirements.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirementAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirementAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirementAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirementAudit.ps1)
