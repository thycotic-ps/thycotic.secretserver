---
title: Search-TssMfaProfile
parent: Configurations
grand_parent: Commands
---
# Search-TssMfaProfile

## SYNOPSIS
Search the MFA authentication profiles

## SYNTAX

```
Search-TssMfaProfile [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the Delinea Platform authentication profiles available for multifactor authentication on secrets.
IsCurrent marks the profile in use.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMfaProfile -TssSession $session | Where-Object IsCurrent
```

Show the MFA authentication profile in use

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

### Thycotic.PowerShell.Configuration.MfaProfile[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud connected to the Delinea Platform only: other instances answer this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssMfaProfile](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssMfaProfile)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssMfaProfile.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssMfaProfile.ps1)
