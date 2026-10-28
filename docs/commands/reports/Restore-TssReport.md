---
title: Restore-TssReport
parent: Reports
grand_parent: Commands
---
# Restore-TssReport

## SYNOPSIS
Restore a deleted system report

## SYNTAX

```
Restore-TssReport [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Restore (undelete) a deleted system report.
Only system reports can be restored this way; a deleted custom report must be edited so its SQL is validated again.
Returns True when the report was restored.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Restore-TssReport -TssSession $session -Id 60
```

Restores deleted system report 60

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
Report ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ReportId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Restore-TssReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Restore-TssReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Restore-TssReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Restore-TssReport.ps1)
