---
title: Get-TssFeatureFlag
parent: Featureflag
grand_parent: Commands
---
# Get-TssFeatureFlag

## SYNOPSIS
Get whether a feature flag is enabled

## SYNTAX

```
Get-TssFeatureFlag [-TssSession] <Session> -Key <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get whether a Secret Server feature flag is enabled.
Returns the key and its state.
Secret Server reports Enabled as False for an unknown key and when it cannot evaluate the flag.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFeatureFlag -TssSession $session -Key inventory, url-type-match
```

Show whether the inventory and url-type-match feature flags are enabled

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

### -Key
Feature flag key, for example inventory or url-type-match

```yaml
Type: String[]
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

### Thycotic.PowerShell.FeatureFlag.State
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/featureflag/Get-TssFeatureFlag](https://thycotic-ps.github.io/thycotic.secretserver/commands/featureflag/Get-TssFeatureFlag)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/featureflag/Get-TssFeatureFlag.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/featureflag/Get-TssFeatureFlag.ps1)
