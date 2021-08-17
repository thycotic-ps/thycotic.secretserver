# Get-TssMetadataField

## SYNOPSIS
Get list of all metadata fields

## SYNTAX

```
Get-TssMetadataField [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get list of all metadata fields

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMetadataField -TssSession $session
```

Return list of all metadata fields that exists

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

### Thycotic.PowerShell.Metadata.FieldSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Get-TssMetadataField](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Get-TssMetadataField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Get-TssMetadataField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Get-TssMetadataField.ps1)

