# Get-TssReportCategory

## SYNOPSIS
Get report categories

## SYNTAX

```
Get-TssReportCategory [-TssSession] <Session> [-Id <Int32[]>] [-All] [<CommonParameters>]
```

## DESCRIPTION
Get a report category by Id or list all

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportCategory -TssSession $session -Id 26
```

Returns Report Category details for 26

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportCategory -TssSession $session
```

Returns a list of all categories

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
Report Category Id, returns all if not provided

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ReportCategoryId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -All
Return list of all categories

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Reports.Category
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategory.ps1)

