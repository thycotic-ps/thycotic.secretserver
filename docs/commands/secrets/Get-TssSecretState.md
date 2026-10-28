---
title: Get-TssSecretState
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretState

## SYNOPSIS
Get details on state of the Secret

## SYNTAX

### state (Default)
```
Get-TssSecretState [-TssSession] <Session> [-Id] <Int32[]>
 [<CommonParameters>]
```

### flags
```
Get-TssSecretState [-TssSession] <Session> [-Id] <Int32[]> [-Flags]
 [<CommonParameters>]
```

### flagsV2
```
Get-TssSecretState [-TssSession] <Session> [-Id] <Int32[]> [-FlagsV2]
 [<CommonParameters>]
```

## DESCRIPTION
Get details on state (requires checkout, restricted actions, etc) of the Secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretState -TssSession $session -Id 42
```

Add minimum example for each parameter

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretState -TssSession $session -Id 42 -Flags
```

Returns the heartbeat status, password change state and password compliance of secret 42

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretState -TssSession $session -Id 42 -FlagsV2
```

Returns the state flags of secret 42 from the v2 endpoint, where PasswordChangeState can also be PreRunValidationFailed

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
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Flags
Return the state flags (heartbeat status, password change state, password compliance) instead of the state details

```yaml
Type: SwitchParameter
Parameter Sets: flags
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FlagsV2
Return the state flags from the v2 endpoint, which adds PreRunValidationFailed to PasswordChangeState

```yaml
Type: SwitchParameter
Parameter Sets: flagsV2
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.DetailState
### Thycotic.PowerShell.Secrets.StateFlags
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretState](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretState.ps1)
