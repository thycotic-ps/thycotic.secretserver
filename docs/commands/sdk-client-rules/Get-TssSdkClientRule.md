---
title: Get-TssSdkClientRule
parent: Sdk Client Rules
grand_parent: Commands
---
# Get-TssSdkClientRule

## SYNOPSIS
Get an SDK client rule by ID

## SYNTAX

```
Get-TssSdkClientRule [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get one or more SDK client rules by ID.
An ID with no matching SDK client rule writes an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSdkClientRule -TssSession $session -Id 3
```

Returns SDK client rule 3

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

### Thycotic.PowerShell.SdkClientRules.SdkClientRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientRule.ps1)
