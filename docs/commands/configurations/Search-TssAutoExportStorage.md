# Search-TssAutoExportStorage

## SYNOPSIS
Search list of items in Automatic Export Storage for Secret Server Cloud

## SYNTAX

```
Search-TssAutoExportStorage [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Search list of items in Automatic Export Storage for Secret Server Cloud

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://tenant.secretservecloud.com -Credential $ssCred
Search-TssAutoExportStorage -TssSession $session
```

Returns a list of items in Automatic Export Storage

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

### Thycotic.PowerShell.Configuration.AutomaticExportItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportStorage](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportStorage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportStorage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportStorage.ps1)

