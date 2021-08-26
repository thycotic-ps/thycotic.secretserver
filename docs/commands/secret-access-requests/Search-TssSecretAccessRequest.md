# Search-TssSecretAccessRequest

## SYNOPSIS
Search Access Request for Secrets by status for current user.

## SYNTAX

```
Search-TssSecretAccessRequest [-TssSession] <Session> [[-Status] <SecretAccessStatus>] [-IsMyRequest]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search Access Request for Secrets by status for current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAccessRequest -TssSession $session -IsMyRequest
```

Return all Access Requests that the connected user submitted

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAccessRequest -TssSession $session -Status Pending
```

Return all pending Access Requests where connected user is submitter or an approver

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

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

### -Status
Status of the request (Pending, Approved, Denied, Canceled), defaults to Pending

```yaml
Type: SecretAccessStatus
Parameter Sets: (All)
Aliases:
Accepted values: Approved, Canceled, Denied, Pending

Required: False
Position: 2
Default value: Pending
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsMyRequest
Is request submitted by connecting user

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

### -SortBy
Sort by specific property, default SecretId

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: SecretId
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AccessRequests.Request
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Search-TssAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Search-TssAccessRequest.ps1)

