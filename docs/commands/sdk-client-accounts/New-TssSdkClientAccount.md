---
title: New-TssSdkClientAccount
parent: Sdk Client Accounts
grand_parent: Commands
---
# New-TssSdkClientAccount

## SYNOPSIS
Register a new SDK client account

## SYNTAX

```
New-TssSdkClientAccount [-TssSession] <Session> [-ClientId <Guid>] -Description <String> -Name <String>
 [-OnboardingKey <String>] -RuleName <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Register a new SDK client account against an SDK client rule, as the SDK client does on init.
The server appends the registration date and time to Name.
The output carries the new ClientSecret: treat it as a credential.
Initialize-TssSdkClient does the same through the SDK client tool and stores the result locally; this cmdlet only calls the REST API.
The onboarding key is not shown in Verbose or WhatIf output.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSdkClientAccount -TssSession $session -Name 'build-agent-01' -Description 'Build agent' -RuleName 'build-agents' -OnboardingKey $onboardingKey
```

Registers SDK client account build-agent-01 against rule build-agents using the onboarding key in $onboardingKey

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

### -ClientId
Client ID (GUID) to register, unique per SDK client account.
A new GUID is used when omitted

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description of the SDK client account

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

### -Name
Name of the SDK client account

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

### -OnboardingKey
Onboarding key of the rule, required when the rule requires one

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

### -RuleName
Name of the SDK client rule to register against

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

### Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/New-TssSdkClientAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/New-TssSdkClientAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/New-TssSdkClientAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/New-TssSdkClientAccount.ps1)
