# Get-TssConfigurationLocalUserPassword

## SYNOPSIS
Get local user password configuration

## SYNTAX

```
Get-TssConfigurationLocalUserPassword [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get local user password configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationLocalUserPassword -TssSession $session
```

Returns local user password configuration for Secret Server

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

### Thycotic.PowerShell.Configuration.LocalUserPasswords
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationLocalUserPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationLocalUserPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationLocalUserPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationLocalUserPassword.ps1)

