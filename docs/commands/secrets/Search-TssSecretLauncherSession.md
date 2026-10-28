---
title: Search-TssSecretLauncherSession
parent: Secrets
grand_parent: Commands
---
# Search-TssSecretLauncherSession

## SYNOPSIS
Search active secret launcher sessions

## SYNTAX

```
Search-TssSecretLauncherSession [-TssSession] <Session> -SecretId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Search the active launcher sessions of one secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretLauncherSession -TssSession $session -SecretId 42
```

Get the active launcher sessions of secret 42

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
Secret Id whose active launcher sessions to return.
Required: Secret Server returns no sessions without it

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

### Thycotic.PowerShell.Secrets.LauncherSession[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretLauncherSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretLauncherSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretLauncherSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretLauncherSession.ps1)
