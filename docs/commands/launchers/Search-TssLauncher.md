---
title: Search-TssLauncher
parent: Launchers
grand_parent: Commands
---
# Search-TssLauncher

## SYNOPSIS
Search launchers

## SYNTAX

```
Search-TssLauncher [-TssSession] <Session> [-Application <String>] [-IncludeInactive] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search launchers (Remote Desktop, PuTTY, Website Login and custom launchers) and return a summary of each.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLauncher -TssSession $session -IncludeInactive
```

Get every launcher, active and inactive

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

### Thycotic.PowerShell.Launchers.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Search-TssLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Search-TssLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Search-TssLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Search-TssLauncher.ps1)
