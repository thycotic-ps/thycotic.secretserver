---
title: Revoke-TssSdkClientAccount
parent: Sdk Client Accounts
grand_parent: Commands
---
# Revoke-TssSdkClientAccount

## SYNOPSIS
Revoke an SDK client account

## SYNTAX

```
Revoke-TssSdkClientAccount [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Revoke one or more SDK client accounts so they can no longer authenticate.
Returns true when revoked.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Revoke-TssSdkClientAccount -TssSession $session -Id 7
```

Revokes SDK client account 7

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
SDK client account ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Revoke-TssSdkClientAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Revoke-TssSdkClientAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Revoke-TssSdkClientAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Revoke-TssSdkClientAccount.ps1)
