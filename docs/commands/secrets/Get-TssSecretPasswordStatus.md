---
title: Get-TssSecretPasswordStatus
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretPasswordStatus

## SYNOPSIS
Get status of password change

## SYNTAX

```
Get-TssSecretPasswordStatus [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get status of password change
Reads the published route GET secrets/secret-detail/{id}/password-status.
Before 0.63.0 this command read the internal route internals/secret-detail/{id}/password-status, which is unsupported and can change in any Secret Server release; the output type is unchanged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPasswordStatus -TssSession $session -Id 26
```

Get password change status of Secret ID 26

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

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

### Thycotic.PowerShell.Secrets.PasswordStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretPasswordStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretPasswordStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretPasswordStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretPasswordStatus.ps1)
