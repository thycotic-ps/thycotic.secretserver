# Get-TssConfigurationSearchIndex

## SYNOPSIS
Get the Secret Search Index configuration

## SYNTAX

```
Get-TssConfigurationSearchIndex [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the Secret Search Index configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfigurationSearchIndex -TssSession $session
```

Returns configuration for Secret Search Indexer

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSearchIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSearchIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSearchIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSearchIndex.ps1)

