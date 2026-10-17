---
title: Get-TssSdkClientRuleStub
parent: Sdk Client Rules
grand_parent: Commands
---
# Get-TssSdkClientRuleStub

## SYNOPSIS
Get the default values for a new SDK client rule

## SYNTAX

```
Get-TssSdkClientRuleStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get an SDK client rule object with the default values for a new rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSdkClientRuleStub -TssSession $session
```

Returns the default values for a new SDK client rule

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SdkClientRules.SdkClientRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientRuleStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientRuleStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientRuleStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientRuleStub.ps1)
