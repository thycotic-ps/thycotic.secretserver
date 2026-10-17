---
title: Get-TssSecretAssociatedSecret
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretAssociatedSecret

## SYNOPSIS
Get the secrets associated with a custom launcher on a secret

## SYNTAX

```
Get-TssSecretAssociatedSecret [-TssSession] <Session> -Id <Int32[]> -LauncherId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the custom launcher (ID and name) and, in order, the secrets it pulls credentials from.
Returns nothing when no secrets are associated.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAssociatedSecret -TssSession $session -Id 42 -LauncherId 4
```

Returns the secrets associated with custom launcher 4 on secret 42

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

### -LauncherId
Custom launcher ID

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

### Thycotic.PowerShell.Secrets.CustomLauncherSettings[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAssociatedSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAssociatedSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAssociatedSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAssociatedSecret.ps1)
