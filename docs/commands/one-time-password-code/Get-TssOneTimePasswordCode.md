---
title: Get-TssOneTimePasswordCode
parent: One Time Password Code
grand_parent: Commands
---
# Get-TssOneTimePasswordCode

## SYNOPSIS
Get one-time password codes for a secret

## SYNTAX

```
Get-TssOneTimePasswordCode [-TssSession] <Session> -Id <Int32[]> [-NumberOfCodesToGenerate <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Get the current one-time password (TOTP) code of a secret with one-time password enabled, and the seconds it stays valid.
Secret Server returns only the current code, whatever NumberOfCodesToGenerate is set to.
The output is credential material.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssOneTimePasswordCode -TssSession $session -Id 42
```

Returns the current one-time password code of secret 42

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

### -NumberOfCodesToGenerate
Number of codes to request. Secret Server ignores it and returns only the current code

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.OneTimePasswordCode.OneTimePassword[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/one-time-password-code/Get-TssOneTimePasswordCode](https://thycotic-ps.github.io/thycotic.secretserver/commands/one-time-password-code/Get-TssOneTimePasswordCode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/one-time-password-code/Get-TssOneTimePasswordCode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/one-time-password-code/Get-TssOneTimePasswordCode.ps1)
