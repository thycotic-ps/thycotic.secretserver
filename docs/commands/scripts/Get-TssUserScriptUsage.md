---
title: Get-TssUserScriptUsage
parent: Scripts
grand_parent: Commands
---
# Get-TssUserScriptUsage

## SYNOPSIS
Get where user scripts are used

## SYNTAX

```
Get-TssUserScriptUsage [-TssSession] <Session> [-ScriptId <Int32>] [-ScriptType <String>] [-UsageType <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the places that use user scripts, such as password changers, dependency changers and discovery scanners.
Returns one row per script and consumer, so a script used in several places appears once per place.
Filter by script ID, script type or usage type.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptUsage -TssSession $session -ScriptId 12
```

List the places that use user script 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptUsage -TssSession $session -ScriptType SSH
```

List where SSH user scripts are used

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

### -ScriptId
Only return usages of this user script ID

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

### -ScriptType
Only return usages of scripts of this type

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

### -UsageType
Only return usages of this type, for example DependencyChanger

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

### Thycotic.PowerShell.Scripts.UserScriptUsage[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptUsage](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptUsage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptUsage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptUsage.ps1)
