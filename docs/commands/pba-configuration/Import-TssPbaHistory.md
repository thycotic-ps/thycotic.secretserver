---
title: Import-TssPbaHistory
parent: Pba Configuration
grand_parent: Commands
---
# Import-TssPbaHistory

## SYNOPSIS
Import historical events into Privilege Behavior Analytics (PBA)

## SYNTAX

```
Import-TssPbaHistory [-TssSession] <Session> [-ProcessImport] [-StartDate <DateTime>] [-EndDate <DateTime>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sends historical Secret Server events to PBA.
With -ProcessImport the server starts the import for the optional StartDate to EndDate window.
Without -ProcessImport nothing is imported and the call returns the result shape only.
Use Get-TssPbaImportStatus to watch the backlog.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssPbaHistory -TssSession $session -ProcessImport -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
```

Imports the last 7 days of events into PBA

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssPbaHistory -TssSession $session -ProcessImport -WhatIf
```

Shows the request without sending it

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

### -ProcessImport
Start the import.
Without it nothing is imported

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

### -StartDate
Start of the import window

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
End of the import window

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.PbaConfiguration.HistoryImport
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Import-TssPbaHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Import-TssPbaHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Import-TssPbaHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Import-TssPbaHistory.ps1)
