# Get-TssSecretWebTemplate

## SYNOPSIS
Get a list of Secret Templates valid for Web Password Filler

## SYNTAX

```
Get-TssSecretWebTemplate [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get a list of Secret Templates valid for Web Password Filler

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretWebTemplate -TssSession $session
```

Return list of Secret Templates that can be used by Web Password Filler

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

### Thycotic.PowerShell.SecretTemplates.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretWebTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretWebTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretWebTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretWebTemplate.ps1)

