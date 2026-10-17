---
title: New-TssEnterpriseSearchRequest
parent: Enterprise
grand_parent: Commands
---
# New-TssEnterpriseSearchRequest

## SYNOPSIS
Start an enterprise search request

## SYNTAX

```
New-TssEnterpriseSearchRequest [-TssSession] <Session> -EnterpriseName <String> [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-RequestField <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts a search of the enterprise data of the named enterprise between two dates and returns the request ID.
Read the result with Get-TssEnterpriseSearchRequest.
EnterpriseName must match an enterprise configured on the server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssEnterpriseSearchRequest -TssSession $session -EnterpriseName 'Contoso' -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
```

Starts an enterprise search over the last 7 days and returns its RequestId

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

### -EnterpriseName
Name of the enterprise to search

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Start of the date range to search

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
End of the date range to search

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

### -RequestField
Field filters as a hashtable of field name and value, for example @{ SecretName = 'web' }

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

### Thycotic.PowerShell.Enterprise.SearchRequest
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/New-TssEnterpriseSearchRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/New-TssEnterpriseSearchRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/New-TssEnterpriseSearchRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/New-TssEnterpriseSearchRequest.ps1)
