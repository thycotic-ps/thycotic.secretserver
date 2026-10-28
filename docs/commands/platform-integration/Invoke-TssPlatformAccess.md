---
title: Invoke-TssPlatformAccess
parent: Platform Integration
grand_parent: Commands
---
# Invoke-TssPlatformAccess

## SYNOPSIS
Start the secure Platform access step of Delinea Platform data integration

## SYNTAX

```
Invoke-TssPlatformAccess [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts the secure access step of Delinea Platform data integration, in which Secret Server configures the Platform identity policies and policy group it needs.
The call only starts the step.
Use Get-TssPlatformAccessProgress to follow it.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssPlatformAccess -TssSession $session -Confirm:$false
```

Starts the secure Platform access step without prompting and returns True when the server accepted the request

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssPlatformAccess -TssSession $session -WhatIf
```

Shows the request that would be sent without starting the step

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Returns True or False (the success flag of the response).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Invoke-TssPlatformAccess](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Invoke-TssPlatformAccess)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Invoke-TssPlatformAccess.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Invoke-TssPlatformAccess.ps1)
