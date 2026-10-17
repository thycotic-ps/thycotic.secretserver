---
title: Test-TssEmailConfiguration
parent: Configurations
grand_parent: Commands
---
# Test-TssEmailConfiguration

## SYNOPSIS
Send a test email

## SYNTAX

```
Test-TssEmailConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Send a test email with the current email configuration to the email address of the calling user.
Returns whether the send succeeded and the server message.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssEmailConfiguration -TssSession $session
```

Send a test email and show whether it succeeded

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

### Thycotic.PowerShell.Configuration.EmailTestResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssEmailConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssEmailConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssEmailConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssEmailConfiguration.ps1)
