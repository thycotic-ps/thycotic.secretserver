---
title: Get-TssEnterpriseSearchRequest
parent: Enterprise
grand_parent: Commands
---
# Get-TssEnterpriseSearchRequest

## SYNOPSIS
Get the result of an enterprise search request

## SYNTAX

```
Get-TssEnterpriseSearchRequest [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the processing start and end time and the result rows (action, date, secret, secret template and user) of an enterprise search request started by New-TssEnterpriseSearchRequest, once the request has completed.
Secret Server returns an error when the request ID does not exist.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEnterpriseSearchRequest -TssSession $session -Id 12
```

Returns the result of enterprise search request 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssEnterpriseSearchRequest -TssSession $session -EnterpriseName 'Contoso' -StartDate (Get-Date).AddDays(-30) -EndDate (Get-Date) | Get-TssEnterpriseSearchRequest -TssSession $session
```

Starts an enterprise search over the last 30 days and reads its result

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
Enterprise search request ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: RequestId

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

### Thycotic.PowerShell.Enterprise.SearchResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/Get-TssEnterpriseSearchRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/Get-TssEnterpriseSearchRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/Get-TssEnterpriseSearchRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/Get-TssEnterpriseSearchRequest.ps1)
