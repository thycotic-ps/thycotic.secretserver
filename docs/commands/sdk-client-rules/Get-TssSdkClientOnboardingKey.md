---
title: Get-TssSdkClientOnboardingKey
parent: Sdk Client Rules
grand_parent: Commands
---
# Get-TssSdkClientOnboardingKey

## SYNOPSIS
Get the onboarding key of an SDK client rule

## SYNTAX

```
Get-TssSdkClientOnboardingKey [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the onboarding key that SDK clients must present to register against the rule.
The output is credential material.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$onboardingKey = Get-TssSdkClientOnboardingKey -TssSession $session -Id 3
```

Stores the onboarding key of SDK client rule 3 in $onboardingKey

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientOnboardingKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientOnboardingKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientOnboardingKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientOnboardingKey.ps1)
