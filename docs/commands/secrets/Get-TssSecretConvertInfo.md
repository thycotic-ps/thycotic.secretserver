---
title: Get-TssSecretConvertInfo
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretConvertInfo

## SYNOPSIS
Get template conversion details for secrets

## SYNTAX

```
Get-TssSecretConvertInfo [-TssSession] <Session> -SecretId <Int32[]> -DestinationTemplateId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the source template fields of the given secrets and the fields of the destination template, to plan the field mapping before converting the secrets to another secret template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretConvertInfo -TssSession $session -SecretId 42, 43 -DestinationTemplateId 6003
```

Returns the source and destination fields for converting secrets 42 and 43 to template 6003

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

### -SecretId
Secret IDs to convert

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretIds

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationTemplateId
Secret template ID to convert to

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.ConvertInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretConvertInfo](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretConvertInfo)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretConvertInfo.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretConvertInfo.ps1)
