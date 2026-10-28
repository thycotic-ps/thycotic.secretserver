---
title: Clear-TssConfigurationAdCredential
parent: Configurations
grand_parent: Commands
---
# Clear-TssConfigurationAdCredential

## SYNOPSIS
Clear cached Active Directory credentials

## SYNTAX

```
Clear-TssConfigurationAdCredential [-TssSession] <Session> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears the Active Directory credentials Secret Server has cached for Active Directory logins, so the next Active Directory login is checked against the domain again.
Returns Success True, also when no Active Directory integration is configured.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssConfigurationAdCredential -TssSession $session
```

Clear the cached Active Directory credentials

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

### Thycotic.PowerShell.Configuration.AdCredentialClearResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Clear-TssConfigurationAdCredential](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Clear-TssConfigurationAdCredential)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Clear-TssConfigurationAdCredential.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Clear-TssConfigurationAdCredential.ps1)
