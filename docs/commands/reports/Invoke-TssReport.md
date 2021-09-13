# Invoke-TssReport

## SYNOPSIS
Executes a report, returning the results as a PSCustomObject

## SYNTAX

```
Invoke-TssReport [-TssSession] <Session> [-ReportId <Int32>] [-ReportName <String>] [-Parameters <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
Executes a report, returning the results as a PSCustomObject

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssReport -TssSession $session -ReportName GroupMembershipReportByGroup -Parameters @{Group = 1}
```

Executes report GroupMembershipReportByGroup returning PSCustomObject result for Everyone group (1)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssReport -TssSession $session -ReportName 'Filter Name' -Parameters @{customtext = 'ada.jupiter.com\brittney.poole - 4073'}
```

Executes report "Filter Name" returning PSCustomObject result based on custom text filter

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssReport -TssSession $session -ReportId 60
```

Executes report 60 (Changed90DaysReportName) returning PSCustomObject result

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

### -ReportId
Report Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReportName
Name of Report

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

### -Parameters
Report Parameters provided as hash format of @{\<Parameter Name\>,\<Param Value\>} (see examples)

```yaml
Type: Hashtable
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

### System.Object
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Invoke-TssReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Invoke-TssReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Invoke-TssReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Invoke-TssReport.ps1)

