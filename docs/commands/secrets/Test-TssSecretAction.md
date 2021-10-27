# Test-TssSecretAction

## SYNOPSIS
Test for an allowed action on a Secret

## SYNTAX

```
Test-TssSecretAction [-TssSession] <Session> -SecretId <Int32> -Action <SecretActions> [<CommonParameters>]
```

## DESCRIPTION
Test for an allowed action on a Secret

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Test-TssSecretAction -TssSession $session -SecretId 75 -Action Edit
```

Test for action Edit on Secret ID 75, returning true if exists and false if not

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

### -Action
Action to test for

```yaml
Type: SecretActions
Parameter Sets: (All)
Aliases:
Accepted values: ChangePasswordNow, ConvertTemplate, Copy, Delete, Edit, EditExpiration, EditRpc, EditSecurity, Expire, Heartbeat, EditShare, ShowSshProxyCredentials, StopChangePasswordNow, ViewAudit, ViewDependencies, ViewLaunchers, ViewExpiration, ViewHooks, ViewRpc, ViewSecurity, ViewSettings, Undelete, ForceCheckIn, ViewShare, EditHooks, EditDependencies, ViewGeneralDetails, ViewHeartbeatStatus, CheckIn, Checkout, GenerateOneTimePassword, ShowSshTerminalDetails, ShowRdpProxyCredentials, ViewMetadata

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

Possible Secret Actions:
'ChangePasswordNow','ConvertTemplate','Copy','Delete','Edit','EditExpiration','EditRpc','EditSecurity','Expire','Heartbeat','EditShare','ShowSshProxyCredentials','StopChangePasswordNow','ViewAudit','ViewDependencies','ViewLaunchers','ViewExpiration','ViewHooks','ViewRpc','ViewSecurity','ViewSettings','Undelete','ForceCheckIn','ViewShare','EditHooks','EditDependencies','ViewGeneralDetails','ViewHeartbeatStatus','CheckIn','Checkout','GenerateOneTimePassword','ShowSshTerminalDetails','ShowRdpProxyCredentials','ViewMetadata'

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretAction](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretAction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretAction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretAction.ps1)

