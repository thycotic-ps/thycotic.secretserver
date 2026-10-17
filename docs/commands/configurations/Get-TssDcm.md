---
title: Get-TssDcm
parent: Configurations
grand_parent: Commands
---
# Get-TssDcm

## SYNOPSIS
Get the Delinea Credential Manager configuration

## SYNTAX

### type (Default)
```
Get-TssDcm [-TssSession] <Session> -Type <String> [<CommonParameters>]
```

### currentUser
```
Get-TssDcm [-TssSession] <Session> [-CurrentUser] [<CommonParameters>]
```

### mobile
```
Get-TssDcm [-TssSession] <Session> [-Mobile] [<CommonParameters>]
```

## DESCRIPTION
Returns Delinea Credential Manager (browser extension) settings.
With -Type, returns the configuration for business users or unrestricted users.
Secret Server serves the business user configuration only to a session authenticated through Delinea Platform; with any other session -Type BusinessUser returns the unrestricted user configuration (Type shows UnrestrictedUser).
With -CurrentUser, returns the settings in effect for the current user.
With -Mobile, returns the mobile offline access limits for the current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDcm -TssSession $session -Type UnrestrictedUser
```

Get the Delinea Credential Manager configuration for unrestricted users

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDcm -TssSession $session -CurrentUser
```

Get the Delinea Credential Manager settings in effect for the current user

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDcm -TssSession $session -Mobile
```

Get the mobile offline access limits for the current user

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

### -Type
Configuration to return: BusinessUser or UnrestrictedUser.
BusinessUser needs a session authenticated through Delinea Platform; with any other session Secret Server returns the unrestricted user configuration

```yaml
Type: String
Parameter Sets: type
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CurrentUser
Return the configuration in effect for the current user

```yaml
Type: SwitchParameter
Parameter Sets: currentUser
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mobile
Return the mobile offline access limits for the current user

```yaml
Type: SwitchParameter
Parameter Sets: mobile
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.Dcm
### Thycotic.PowerShell.Configuration.DcmCurrentUser
### Thycotic.PowerShell.Configuration.DcmMobile
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDcm](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDcm)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDcm.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDcm.ps1)
