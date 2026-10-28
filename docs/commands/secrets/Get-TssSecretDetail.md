---
title: Get-TssSecretDetail
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretDetail

## SYNOPSIS
Get the general details of a secret

## SYNTAX

```
Get-TssSecretDetail [-TssSession] <Session> -Id <Int32[]> [-IsEditMode] [-LoadReadOnlyFlags]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the general details of a secret as the web UI shows them: name, folder, template, site, secret policy, heartbeat and password compliance status, launchers, SSH key and TOTP settings.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDetail -TssSession $session -Id 42
```

Returns the general details of secret 42

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

### -IsEditMode
Return the details as the edit view loads them

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

### -LoadReadOnlyFlags
Include read only flags

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.DetailGeneral
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretDetail](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretDetail)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretDetail.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretDetail.ps1)
