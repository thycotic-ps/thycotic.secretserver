---
title: Update-TssMfaProfile
parent: Configurations
grand_parent: Commands
---
# Update-TssMfaProfile

## SYNOPSIS
Update the MFA authentication profile in use

## SYNTAX

```
Update-TssMfaProfile [-TssSession] <Session> -Id <Guid> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Make a Delinea Platform authentication profile the one used for multifactor authentication on secrets.
Returns every profile, with IsCurrent on the one now in use.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMfaProfile -TssSession $session | Where-Object Name -EQ 'Default MFA' | Update-TssMfaProfile -TssSession $session
```

Use the Default MFA authentication profile

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
Id of the authentication profile to use

```yaml
Type: Guid
Parameter Sets: (All)
Aliases: AuthProfileId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Update-TssMfaProfile](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Update-TssMfaProfile)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Update-TssMfaProfile.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Update-TssMfaProfile.ps1)
