# New-TssSecretHook

## SYNOPSIS
Create a Secret Hook

## SYNTAX

```
New-TssSecretHook [-TssSession] <Session> -SecretId <Int32[]> -SecretHookStub <Hook> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a Secret Hook

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
$stub = Get-TssSecretHookStub -TssSession $session -SecretId 391 -ScriptId 6 -Name 'Test Hook' -PrePostOption PRE -EventAction CheckIn
New-TssSecretHook -TssSession $session -SecretId 2 -SecretHookStub $stub
```

Update Secret Hook 2's Arguments property on Secret ID 76

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
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SecretHookStub
Secret Hook Stub object

```yaml
Type: Hook
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/New-TssSecretHook](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/New-TssSecretHook)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/New-TssSecretHook.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/New-TssSecretHook.ps1)

