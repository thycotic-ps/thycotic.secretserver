# Get-TssSecretHook

## SYNOPSIS
Get details of a Secret Hook

## SYNTAX

```
Get-TssSecretHook [-TssSession] <Session> -SecretId <Int32> -SecretHookId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get details of a Secret Hook

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretHook -TssSession $session -SecretId 376 -SecretHookId 1
```

Get details of Secret Hook ID 1 of Secret ID 376

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
Secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretHookId
Secret Hook ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: HookId

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

### Thycotic.PowerShell.SecretHooks.Hook
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHook](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHook)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-TssSecretHook.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-TssSecretHook.ps1)

