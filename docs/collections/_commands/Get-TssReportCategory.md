---
category: reports
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic.secretserver.github.io/commands/Get-TssReportCategory
schema: 2.0.0
title: Get-TssReportCategory
---

# Get-TssReportCategory

## SYNOPSIS
Get report categories

## SYNTAX

```
Get-TssReportCategory [-TssSession] <TssSession> [-Id <Int32[]>] [-All] [-Raw] [<CommonParameters>]
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
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
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

### -Raw
Output the raw response from the API endpoint

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

### TssReportCategory
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic.secretserver.github.io/commands/Get-TssReportCategory](https://thycotic.secretserver.github.io/commands/Get-TssReportCategory)

