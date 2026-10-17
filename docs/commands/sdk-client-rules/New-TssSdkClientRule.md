---
title: New-TssSdkClientRule
parent: Sdk Client Rules
grand_parent: Commands
---
# New-TssSdkClientRule

## SYNOPSIS
Create a new SDK client rule

## SYNTAX

```
New-TssSdkClientRule [-TssSession] <Session> [-Details <String>] -Name <String> [-RequireOnboardingKey]
 [-UserId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new SDK client rule.
SDK clients register against a rule by name and run as the rule user.
Details restricts the addresses SDK clients may register from.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSdkClientRule -TssSession $session -Name 'build-agents' -Details '10.20.0.0/16' -UserId 12 -RequireOnboardingKey
```

Creates rule build-agents for clients in 10.20.0.0/16 that run as user 12 and need an onboarding key

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

### -Details
IP address range or CIDR that SDK clients must register from, for example 10.20.0.0/16.
Empty allows any address

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

### -Name
Name of the SDK client rule

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

### -RequireOnboardingKey
Require an onboarding key to register against the rule

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

### -UserId
ID of the user SDK client accounts on this rule run as

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

### Thycotic.PowerShell.SdkClientRules.SdkClientRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/New-TssSdkClientRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/New-TssSdkClientRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/New-TssSdkClientRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/New-TssSdkClientRule.ps1)
