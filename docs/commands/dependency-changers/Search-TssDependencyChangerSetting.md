---
title: Search-TssDependencyChangerSetting
parent: Dependency Changers
grand_parent: Commands
---
# Search-TssDependencyChangerSetting

## SYNOPSIS
List dependency changer settings

## SYNTAX

```
Search-TssDependencyChangerSetting [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the catalog of dependency changer settings (for example Port, WaitBeforeSeconds) with their default values.
Use the setting names with -Setting on New-TssDependencyChanger and Set-TssDependencyChanger.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyChangerSetting -TssSession $session
```

List the dependency changer settings and their defaults

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

### Thycotic.PowerShell.DependencyChangers.Setting[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerSetting.ps1)
