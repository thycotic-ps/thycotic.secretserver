# Export-TssAutoExportStorageItem

## SYNOPSIS
Export the Automatic Export Storage Item

## SYNTAX

```
Export-TssAutoExportStorageItem [-TssSession] <Session> -Id <Int32> -Filename <String> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Export the Automatic Export Storage Item, output will show the latest as the first object

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
$item = Search-TssAutoExportStorage -TssSession $session
Export-TssAutoExportStorageItem -TssSession $session -Id $item[0].Id -Filename $item[0].Filename -Output C:\temp\backup
```

Exports the latest automatic secret export zip file to C:\temp\backup\\\<filename\>.zip

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.au -Credential $ssCred
Search-TssAutoExportStorage -TssSession $session | select -First 1 | Export-TssAutoExportStorageItem -TssSession $session -Output C:\temp\backup
```

Exports the latest automatic secret export zip file to C:\temp\backup\\\<filename\>.zip

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

### -Id
Automatic Export Item ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filename
Automatic Export Item Filename

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Output
Output folder

```yaml
Type: String
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Export-TssAutoExportStorageItem](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Export-TssAutoExportStorageItem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/sExport-TssAutoExportStorageItem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/sExport-TssAutoExportStorageItem.ps1)

