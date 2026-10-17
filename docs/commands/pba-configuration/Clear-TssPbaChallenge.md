---
title: Clear-TssPbaChallenge
parent: Pba Configuration
grand_parent: Commands
---
# Clear-TssPbaChallenge

## SYNOPSIS
Clear Privilege Behavior Analytics (PBA) challenges

## SYNTAX

```
Clear-TssPbaChallenge [-TssSession] <Session> -Id <Int32[]> -ClearingUserId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears (acknowledges) one or more PBA challenges by challenge id, recording the user who cleared them.
Ids the server does not find are skipped.
Returns true when the request succeeds.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssPbaChallenge -TssSession $session -Id 42, 43 -ClearingUserId 2
```

Clears challenges 42 and 43 as user 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPbaChallenge -TssSession $session -SearchText jsmith | Clear-TssPbaChallenge -TssSession $session -ClearingUserId 2
```

Clears every challenge from the last day that matches jsmith as user 2

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
PBA challenge id (SecurityAnalyticsChallengeId in Search-TssPbaChallenge output)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecurityAnalyticsChallengeId, ChallengeId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ClearingUserId
User id recorded as the user who cleared the challenges

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Clear-TssPbaChallenge](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Clear-TssPbaChallenge)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Clear-TssPbaChallenge.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Clear-TssPbaChallenge.ps1)
