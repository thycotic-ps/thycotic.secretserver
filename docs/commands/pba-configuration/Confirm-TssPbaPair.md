---
title: Confirm-TssPbaPair
parent: Pba Configuration
grand_parent: Commands
---
# Confirm-TssPbaPair

## SYNOPSIS
Confirm the Secret Server key pair with Privilege Behavior Analytics (PBA)

## SYNTAX

```
Confirm-TssPbaPair [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Queues confirmation of the Secret Server application key with the configured PBA instance.
AlreadyApproved is true when the current key is already approved, in which case nothing is queued.
Fails when PBA is not configured.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Confirm-TssPbaPair -TssSession $session
```

Confirms the key pair with PBA

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

### Thycotic.PowerShell.PbaConfiguration.PairResult
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Confirm-TssPbaPair](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Confirm-TssPbaPair)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Confirm-TssPbaPair.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Confirm-TssPbaPair.ps1)
