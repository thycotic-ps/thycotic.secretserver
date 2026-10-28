---
title: Test-TssConfigurationRadius
parent: Configurations
grand_parent: Commands
---
# Test-TssConfigurationRadius

## SYNOPSIS
Test a RADIUS login

## SYNTAX

```
Test-TssConfigurationRadius [-TssSession] <Session> -Credential <PSCredential>
 [<CommonParameters>]
```

## DESCRIPTION
Tests a login against the RADIUS server in the login configuration.
Returns Success False when the RADIUS server rejects the credential or no RADIUS server is configured; a failed login is not an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$radiusCred = Get-Credential
Test-TssConfigurationRadius -TssSession $session -Credential $radiusCred
```

Test a RADIUS login with the user name and password entered at the prompt

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

### -Credential
RADIUS user name and password to test

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.RadiusTestResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssConfigurationRadius](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssConfigurationRadius)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssConfigurationRadius.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssConfigurationRadius.ps1)
