# Get-TssSecretTemplate

## SYNOPSIS
Get a secret template from Secret Server

## SYNTAX

```
Get-TssSecretTemplate [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a secret template(s) from Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplate -Id 93
```

Returns secret associated with the Secret ID, 93

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
Secret template ID to retrieve

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TemplateId, SecretTemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplate.ps1)

