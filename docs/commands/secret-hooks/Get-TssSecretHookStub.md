# Get-TssSecretHookStub

## SYNOPSIS
Get stub for a new Secret Hook

## SYNTAX

```
Get-TssSecretHookStub [-TssSession] <TssSession> -SecretId <Int32[]> -ScriptId <Int32> -Name <String>
 -PrePostOption <String> [-EventAction <String>] [<CommonParameters>]
```

## DESCRIPTION
Get stub for a new Secret Hook

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Get-TssSecretHookStub -TssSession $session -SecretId 391 -ScriptId 6 -Name 'Test Hook' -PrePostOption PRE -EventAction CheckIn
```

Get stub for Secret ID 391 and Script 6 with prepopulated settings for Name, PrePostOption and Event Action.

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScriptId
Script ID

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

### -Name
Name of Secret Hook

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrePostOption
PRE/POST Option

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventAction
Event Action, allowed: CheckIn, Checkout

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### TssSecretHook
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHookStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHookStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-SecretHookStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-SecretHookStub.ps1)

