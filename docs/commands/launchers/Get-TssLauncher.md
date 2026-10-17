---
title: Get-TssLauncher
parent: Launchers
grand_parent: Commands
---
# Get-TssLauncher

## SYNOPSIS
Get a launcher

## SYNTAX

```
Get-TssLauncher [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a launcher by Id, including its custom launcher Id, process name and parameters when it is a custom launcher.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncher -TssSession $session -Id 2
```

Get launcher 2 (PuTTY on a default install)

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
Launcher Id

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

### Thycotic.PowerShell.Launchers.Launcher
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Get-TssLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Get-TssLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Get-TssLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Get-TssLauncher.ps1)
