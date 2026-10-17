---
title: Set-TssSdkClientEnabled
parent: Sdk Client Accounts
grand_parent: Commands
---
# Set-TssSdkClientEnabled

## SYNOPSIS
Enable or disable SDK client accounts

## SYNTAX

```
Set-TssSdkClientEnabled [-TssSession] <Session> -Enabled <Boolean>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enable or disable the SDK client accounts feature.
Returns the new state.
The API toggles the state, so the current state is read first and no request is sent when it already matches Enabled.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSdkClientEnabled -TssSession $session -Enabled $true
```

Enables SDK client accounts

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSdkClientEnabled -TssSession $session -Enabled $false
```

Disables SDK client accounts

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

### -Enabled
True to enable SDK client accounts, false to disable them

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Set-TssSdkClientEnabled](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Set-TssSdkClientEnabled)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Set-TssSdkClientEnabled.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Set-TssSdkClientEnabled.ps1)
