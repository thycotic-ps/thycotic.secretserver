---
title: New-TssSecretEraseRequest
parent: Secret Erase Requests
grand_parent: Commands
---
# New-TssSecretEraseRequest

## SYNOPSIS
Create a secret erase request

## SYNTAX

```
New-TssSecretEraseRequest [-TssSession] <Session> -SecretId <Int32[]> -EraseAfter <DateTime>
 [-Comment <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Requests that the given secrets be permanently erased after the EraseAfter date.
The request goes through erase approval; approvers approve or deny it with Update-TssSecretEraseRequest.
Requires the Secret Erase feature.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretEraseRequest -TssSession $session -SecretId 42, 43 -EraseAfter (Get-Date).AddDays(7) -Comment 'Decommissioned servers'
```

Requests that secrets 42 and 43 be erased in 7 days

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

### -SecretId
Secret IDs to erase

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretIds

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EraseAfter
Date after which the secrets are erased

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment
Reason for the request

```yaml
Type: String
Parameter Sets: (All)
Aliases: RequestComment

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

### Thycotic.PowerShell.EraseRequests.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/New-TssSecretEraseRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/New-TssSecretEraseRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/New-TssSecretEraseRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/New-TssSecretEraseRequest.ps1)
