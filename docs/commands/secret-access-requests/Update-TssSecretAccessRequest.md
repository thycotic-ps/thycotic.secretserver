# Update-TssSecretAccessRequest

## SYNOPSIS
Update a Access Request for the current user

## SYNTAX

```
Update-TssSecretAccessRequest [-TssSession] <Session> -RequestId <Int32> -Status <SecretAccessStatus>
 [-StartDate <String>] [-ExpirationDate <String>] [-Response <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update a Access Request for the current user

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Update-TssSecretAccessRequest -TssSession $session -RequestId
```

Update ...

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

### -RequestId
Secret Access Request Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretAccessRequestId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
Set the status desired (Pending, Approved, Denied, Canceled)

```yaml
Type: SecretAccessStatus
Parameter Sets: (All)
Aliases:
Accepted values: Approved, Canceled, Denied, Pending

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Start date, defaults to now (current datetime)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [datetime]::Now
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpirationDate
Expiration date

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

### -Response
Response or comment

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Update-TssSecretAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Update-TssSecretAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Update-TssSecretAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Update-TssSecretAccessRequest.ps1)

