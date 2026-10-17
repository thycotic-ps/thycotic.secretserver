---
title: Test-TssPbaConnection
parent: Pba Configuration
grand_parent: Commands
---
# Test-TssPbaConnection

## SYNOPSIS
Test the Privilege Behavior Analytics (PBA) connection

## SYNTAX

```
Test-TssPbaConnection [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Asks Secret Server to contact the configured PBA instance.
Returns true when the health check succeeds.
When PBA is disabled or not configured the server returns an error (API_PbaHealthCheckError).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssPbaConnection -TssSession $session
```

Returns true when Secret Server can reach PBA

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Test-TssPbaConnection](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Test-TssPbaConnection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Test-TssPbaConnection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Test-TssPbaConnection.ps1)
