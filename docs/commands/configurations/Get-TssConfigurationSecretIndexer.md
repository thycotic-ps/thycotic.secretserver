# Get-TssConfigurationSecretIndexer

## SYNOPSIS
Get Secret Indexer configuration

## SYNTAX

```
Get-TssConfigurationSecretIndexer [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get Secret Indexer configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationIndexer -TssSession $session - some test value
```

Return configuration of the Secret Search Indexer

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

### Thycotic.PowerShell.Configuration.SearchIndexer
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configuration/Get-TssConfigurationSecretIndexer](https://thycotic-ps.github.io/thycotic.secretserver/commands/configuration/Get-TssConfigurationSecretIndexer)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configuration/Get-TssConfigurationSecretIndexer.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configuration/Get-TssConfigurationSecretIndexer.ps1)

