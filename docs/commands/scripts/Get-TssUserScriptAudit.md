---
title: Get-TssUserScriptAudit
parent: Scripts
grand_parent: Commands
---
# Get-TssUserScriptAudit

## SYNOPSIS
Get the audit trail of user script changes

## SYNTAX

```
Get-TssUserScriptAudit [-TssSession] <Session> [-ScriptId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists user script audit entries: who created, viewed or changed which script, when, from which IP address, and what changed.
Pass -ScriptId for the entries of one script; omit it for the entries of every script.
ScriptHistoryId is set when the change saved a copy of the script body: pass it to Get-TssUserScriptHistory to read that version.
It is 0 when the entry saved no body, such as a view or a parameter-only edit.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptAudit -TssSession $session -ScriptId 12
```

List the audit entries of user script 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserScriptAudit -TssSession $session | Where-Object Action -EQ 'UPDATE'
```

List every user script update

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
Only return the audit entries of this user script ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Scripts.UserScriptAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptAudit.ps1)
