---
title: Get-TssSecretHealthExposure
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretHealthExposure

## SYNOPSIS
Get the users who viewed a secret since its last password change

## SYNTAX

```
Get-TssSecretHealthExposure [-TssSession] <Session> -Id <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret exposure check: every user who viewed the secret since its password last changed, and whether each can still view it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretHealthExposure -TssSession $session -Id 42
```

Returns the users who viewed secret 42 since its last password change

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.HealthExposure[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHealthExposure](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHealthExposure)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHealthExposure.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHealthExposure.ps1)
