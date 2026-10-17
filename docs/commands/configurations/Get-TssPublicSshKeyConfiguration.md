---
title: Get-TssPublicSshKeyConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssPublicSshKeyConfiguration

## SYNOPSIS
Get the public SSH key configuration

## SYNTAX

```
Get-TssPublicSshKeyConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the public SSH key settings: whether users can manage public SSH keys, whether a passphrase is required and when keys expire.
No key material is returned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPublicSshKeyConfiguration -TssSession $session
```

Returns the public SSH key configuration

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

### Thycotic.PowerShell.Configuration.PublicSshKeyConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPublicSshKeyConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPublicSshKeyConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPublicSshKeyConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPublicSshKeyConfiguration.ps1)
