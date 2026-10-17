---
title: Search-TssSecretTemplateField
parent: Secret Templates
grand_parent: Commands
---
# Search-TssSecretTemplateField

## SYNOPSIS
Search secret template fields

## SYNTAX

### Default (Default)
```
Search-TssSecretTemplateField [-TssSession] <Session> [-IncludeInactive] [-SecretId <Int32>]
 [-SecretTemplateId <Int32>] [<CommonParameters>]
```

### Basic
```
Search-TssSecretTemplateField [-TssSession] <Session> [-IncludeInactive] [-SecretTemplateId <Int32>] [-Basic]
 [<CommonParameters>]
```

## DESCRIPTION
Returns secret template fields, filtered by template or secret.
Use -Basic for the reduced field list (ID, name, slug name, sort order, active) that basic users can read.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001
```

Get the active fields of template 6001

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001 -IncludeInactive -Basic
```

Get the basic details of every field of template 6001, inactive fields included

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
Include inactive fields

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

### -SecretId
Return only fields of the template used by this secret ID

```yaml
Type: Int32
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTemplateId
Return only fields of this secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Basic
Use the basic field search, which returns ID, name, slug name, sort order and active only

```yaml
Type: SwitchParameter
Parameter Sets: Basic
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.FieldSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateField.ps1)
