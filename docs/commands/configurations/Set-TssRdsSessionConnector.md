---
title: Set-TssRdsSessionConnector
parent: Configurations
grand_parent: Commands
---
# Set-TssRdsSessionConnector

## SYNOPSIS
Update the RDS Session Connector configuration

## SYNTAX

```
Set-TssRdsSessionConnector [-TssSession] <Session> [-AllowConnectionSharing] [-CertificateSecretId <Int32>]
 [-Enabled] [-SessionTimeoutInSeconds <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update the RDS Session Connector configuration, which launches RDP sessions through a Remote Desktop Services collection.
-Enabled is required on every call: the server rejects a patch without it (HTTP 500).
The other parameters change only when passed.
Returns the configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRdsSessionConnector -TssSession $session -Enabled:$false
```

Turn the RDS Session Connector off

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRdsSessionConnector -TssSession $session -Enabled -SessionTimeoutInSeconds 3600 -CertificateSecretId 42
```

Turn the connector on with a one-hour timeout and the certificate in secret 42

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

### -AllowConnectionSharing
Allow a connector session to be shared

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

### -CertificateSecretId
Id of the secret that holds the connector certificate

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enabled
Turn the session connector on (-Enabled) or off (-Enabled:$false).
Required

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionTimeoutInSeconds
Session timeout in seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

### Thycotic.PowerShell.Configuration.RdsSessionConnector
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssRdsSessionConnector](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssRdsSessionConnector)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssRdsSessionConnector.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssRdsSessionConnector.ps1)
