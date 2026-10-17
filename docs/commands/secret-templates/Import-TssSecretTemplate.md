---
title: Import-TssSecretTemplate
parent: Secret Templates
grand_parent: Commands
---
# Import-TssSecretTemplate

## SYNOPSIS
Import a secret template from XML

## SYNTAX

```
Import-TssSecretTemplate [-TssSession] <Session> -TemplateXml <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a secret template from template XML, such as the ExportFileText of an XML export from Export-TssSecretTemplate.
Returns the new template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$xml = Get-Content -Path ./template-6001.xml -Raw
Import-TssSecretTemplate -TssSession $session -TemplateXml $xml
```

Create a secret template from an exported XML file

### EXAMPLE 2
```
$source = New-TssSession -SecretServer https://alpha -Credential $ssCred
$target = New-TssSession -SecretServer https://beta -Credential $ssCred
Export-TssSecretTemplate -TssSession $source -Id 6001 | Import-TssSecretTemplate -TssSession $target
```

Copy template 6001 from one Secret Server to another

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

### -TemplateXml
Secret template XML.
Accepts the ExportFileText property of Export-TssSecretTemplate output from the pipeline

```yaml
Type: String
Parameter Sets: (All)
Aliases: ExportFileText

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.SecretTemplates.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Import-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Import-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Import-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Import-TssSecretTemplate.ps1)
