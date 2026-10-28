---
title: Export-TssSecretTemplate
parent: Secret Templates
grand_parent: Commands
---
# Export-TssSecretTemplate

## SYNOPSIS
Export a secret template

## SYNTAX

```
Export-TssSecretTemplate [-TssSession] <Session> -Id <Int32[]> [-Format <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Exports a secret template definition.
The ExportFileText property holds the template as XML (the default) or JSON, and FileName holds a suggested file name.
Pass an XML export to Import-TssSecretTemplate to create the template on another Secret Server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$export = Export-TssSecretTemplate -TssSession $session -Id 6001
Set-Content -Path ./template-6001.xml -Value $export.ExportFileText
```

Export template 6001 as XML and save it to a file

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Export-TssSecretTemplate -TssSession $session -Id 6001 -Format json
```

Export template 6001 as JSON

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
Secret template ID to export

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Format
Export format: xml (default) or json

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.Export
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Export-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Export-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Export-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Export-TssSecretTemplate.ps1)
