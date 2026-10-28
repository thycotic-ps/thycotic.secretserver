---
title: Get-TssUserScriptHistory
parent: Scripts
grand_parent: Commands
---
# Get-TssUserScriptHistory

## SYNOPSIS
Get an earlier version of a user script

## SYNTAX

```
Get-TssUserScriptHistory [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the script body saved by one change.
ScriptName and ScriptType are the script's current name and type, not the values at that point.
The ID is a script history ID, taken from the ScriptHistoryId property of Get-TssUserScriptAudit output.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptHistory -TssSession $session -Id 327
```

Get the script body saved by script history entry 327

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptAudit -TssSession $session -ScriptId 12 | Where-Object ScriptHistoryId | Get-TssUserScriptHistory -TssSession $session
```

Get every saved version of user script 12

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
Script history ID (ScriptHistoryId from Get-TssUserScriptAudit)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScriptHistoryId

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

### Thycotic.PowerShell.Scripts.UserScriptHistory
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptHistory.ps1)
