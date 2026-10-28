---
title: Find-TssLauncher
parent: Launchers
grand_parent: Commands
---
# Find-TssLauncher

## SYNOPSIS
Find launchers by name

## SYNTAX

```
Find-TssLauncher [-TssSession] <Session> [-Application <String>] [-IncludeInactive] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search launchers and return the lookup form (Id and name as Value).
Use Search-TssLauncher for the full launcher summary.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Find-TssLauncher -TssSession $session -SearchText Remote
```

Find launchers whose name contains Remote

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

### -Application
Launcher application to filter by, for example mstsc, putty or web

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

### -IncludeInactive
Include inactive launchers

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

### -SearchText
Text to match against the launcher name

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

### Thycotic.PowerShell.Launchers.Lookup[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Find-TssLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Find-TssLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Find-TssLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Find-TssLauncher.ps1)
