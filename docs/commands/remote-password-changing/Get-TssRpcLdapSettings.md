---
title: Get-TssRpcLdapSettings
parent: Remote Password Changing
grand_parent: Commands
---
# Get-TssRpcLdapSettings

## SYNOPSIS
Get the LDAP connection settings for a password type

## SYNTAX

```
Get-TssRpcLdapSettings [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the LDAP connection settings that an LDAP password type (for example LDAP (Active Directory) or LDAP (OpenLDAP)) uses to change passwords.
The ID is the LDAP connection settings ID, not the password type ID: read it from the LdapConnectionSettingsId property of Get-TssRpcPasswordType output.
An ID that is not an LDAP connection settings ID returns a server error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcLdapSettings -TssSession $session -Id 2
```

Get LDAP connection settings 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcPasswordType -TssSession $session -Id 21 | Get-TssRpcLdapSettings -TssSession $session
```

Get the LDAP connection settings used by password type 21

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
LDAP connection settings ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: LdapConnectionSettingsId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Rpc.LdapSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcLdapSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcLdapSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcLdapSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcLdapSettings.ps1)
