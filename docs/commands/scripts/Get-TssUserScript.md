---
title: Get-TssUserScript
parent: Scripts
grand_parent: Commands
---
# Get-TssUserScript

## SYNOPSIS
Get a user script by ID, including its body and type settings

## SYNTAX

```
Get-TssUserScript [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets one or more user scripts by ID through the v2 userscripts endpoint.
Unlike Get-TssScript, the result carries the type settings in AdditionalData (powerShellSettings, sqlSettings or sshSettings) and the concurrency ID.
UsageCount is always 0 because the server does not fill it in: use Get-TssUserScriptUsage to list where a script is used.
ScriptType is returned as the type name (PowerShell, SQL or SSH).
An ID with no matching script writes an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScript -TssSession $session -Id 12
```

Get user script 12 with its body and type settings

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssUserScript -TssSession $session -Id 12).AdditionalData.sqlSettings
```

Show the database, port and parameters of SQL user script 12

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
User script ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScriptId

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

### Thycotic.PowerShell.Scripts.ScriptItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScript.ps1)
