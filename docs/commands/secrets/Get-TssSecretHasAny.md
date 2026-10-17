---
title: Get-TssSecretHasAny
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretHasAny

## SYNOPSIS
Test whether the current user can see any secret

## SYNTAX

```
Get-TssSecretHasAny [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns True when the current user has access to at least one secret, False otherwise.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretHasAny -TssSession $session
```

Returns True when the signed-in user can see at least one secret

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHasAny](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHasAny)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHasAny.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHasAny.ps1)
