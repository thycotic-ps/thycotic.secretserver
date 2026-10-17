---
title: Convert-TssSecretTemplate
parent: Secrets
grand_parent: Commands
---
# Convert-TssSecretTemplate

## SYNOPSIS
Convert secrets to a different secret template

## SYNTAX

```
Convert-TssSecretTemplate [-TssSession] <Session> [-FieldMapping <Object[]>] [-FolderId <Int32>] [-Bulk]
 [-NewSecretName <String>] -SecretId <Int32[]> -SecretTemplateId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Converts one or more secrets to another secret template, mapping fields of the current template to fields of the new one.
Secret Server runs the conversion as a background task and returns a secret ID and the task ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$map = @(@{ sourceFieldId = 87; destinationFieldId = 108 }, @{ sourceFieldId = 88; destinationFieldId = 109 })
Convert-TssSecretTemplate -TssSession $session -SecretId 42 -SecretTemplateId 6003 -FieldMapping $map
```

Converts secret 42 to template 6003, copying two fields

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Convert-TssSecretTemplate -TssSession $session -SecretId 42, 43, 44 -SecretTemplateId 6003 -FieldMapping $map -Bulk
```

Converts three secrets to template 6003 in one job

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

### -FieldMapping
Field mapping, one hashtable per field: @{ sourceFieldId = \<id\>; destinationFieldId = \<id\> }.
Field IDs come from Get-TssSecretTemplate

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
ID of the folder for the converted secret

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

### -Bulk
Convert several secrets in one job.
Use it when SecretId holds more than one ID

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

### -NewSecretName
New name for the converted secret, single secret conversions only

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

### -SecretId
ID of each secret to convert

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTemplateId
ID of the secret template to convert to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
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

### Thycotic.PowerShell.Secrets.TemplateConversion
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Convert-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Convert-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Convert-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Convert-TssSecretTemplate.ps1)
