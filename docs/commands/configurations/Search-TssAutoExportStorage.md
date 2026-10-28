---
title: Search-TssAutoExportStorage
parent: Configurations
grand_parent: Commands
---
# Search-TssAutoExportStorage

## SYNOPSIS
Search list of items in Automatic Export Storage for Secret Server Cloud

## SYNTAX

```
Search-TssAutoExportStorage [-TssSession] <Session> [-ConfigurationId <Int32>]
 [<CommonParameters>]
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

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
Search-TssAutoExportStorage -TssSession $session -ConfigurationId 2
```

Returns the items in Automatic Export Storage for automatic export configuration 2

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

### -ConfigurationId
Automatic export configuration id; returns that configuration's storage items instead of the default configuration's

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
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