# Test-TssSecretState

## SYNOPSIS
Test for a State on a Secret

## SYNTAX

```
Test-TssSecretState [-TssSession] <Session> -SecretId <Int32> -State <SecretStates> [<CommonParameters>]
```

## DESCRIPTION
Test for a State on a Secret

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Test-TssSecretState -TssSession $session -SecretId 75 -State RequiresCheckout
```

Test for state RequiresCheckout on Secret ID 75, returning true if exists and false if not

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
Secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State
State to test for

```yaml
Type: SecretStates
Parameter Sets: (All)
Aliases:
Accepted values: None, RequiresApproval, RequiresCheckout, RequiresComment, RequiresDoubleLockPassword, CreateDoubleLockPassword, DoubleLockNoAccess, CannotView, RequiresUndelete, RequiresCheckoutPendingRPC, RequiresCheckoutAndComment

Required: True
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

Possible Secret States:
'None','RequiresApproval','RequiresCheckout','RequiresComment','RequiresDoubleLockPassword','CreateDoubleLockPassword','DoubleLockNoAccess','CannotView','RequiresUndelete','RequiresCheckoutPendingRPC','RequiresCheckoutAndComment'

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretState](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretState.ps1)

