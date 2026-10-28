---
title: Remove-TssSdkClientRule
parent: Sdk Client Rules
grand_parent: Commands
---
# Remove-TssSdkClientRule

## SYNOPSIS
Delete an SDK client rule

## SYNTAX

```
Remove-TssSdkClientRule [-TssSession] <Session> -Id <Int32[]> [-RevokeAccounts]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete one or more SDK client rules by ID.
RevokeAccounts also revokes the SDK client accounts registered through the rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSdkClientRule -TssSession $session -Id 3 -RevokeAccounts
```

Deletes SDK client rule 3 and revokes its SDK client accounts

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
SDK client rule ID

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

### -RevokeAccounts
Also revoke the SDK client accounts registered through the rule

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Remove-TssSdkClientRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Remove-TssSdkClientRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Remove-TssSdkClientRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Remove-TssSdkClientRule.ps1)
