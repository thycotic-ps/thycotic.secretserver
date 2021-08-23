# Get-TssConfigurationSiteConnector

## SYNOPSIS
List Site Connectors

## SYNTAX

```
Get-TssConfigurationSiteConnector [-TssSession] <Session> [-IncludeInactive] [<CommonParameters>]
```

## DESCRIPTION
List Site Connectors

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationSiteConnector -TssSession $session -IncludeInactive
```

List all site connectors, include those that are inactive

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

### -IncludeInactive
Include inactive

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.SiteConnector
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSiteConnector](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSiteConnector)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSiteConnector.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSiteConnector.ps1)

