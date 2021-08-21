# Get-TssConfigurationSecurity

## SYNOPSIS
Get security configuration

## SYNTAX

```
Get-TssConfigurationSecurity [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get security configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationSecurity -TssSession $session
```

Returns security configuration for Secret Server

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

### Thycotic.PowerShell.Configuration.Security
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSecurity](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSecurity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSecurity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSecurity.ps1)

