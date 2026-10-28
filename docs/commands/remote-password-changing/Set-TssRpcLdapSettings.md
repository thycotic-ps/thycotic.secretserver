---
title: Set-TssRpcLdapSettings
parent: Remote Password Changing
grand_parent: Commands
---
# Set-TssRpcLdapSettings

## SYNOPSIS
Update the LDAP settings for an RPC password type

## SYNTAX

```
Set-TssRpcLdapSettings [-TssSession] <Session> -Id <Int32> [-AuthType <String>]
 [-ConvertUserToDistinguishedName] [-LookupDistinguishedNameForConnection] [-LookupDistinguishedNameForReset]
 [-PasswordAttribute <String>] [-PasswordEncodingType <String>] [-ProtocolVersion <Int32>] [-SecureSocketLayer]
 [-UserDistinguishedNameFormat <String>] [-UserNameAuthenticationFormat <String>] [-UserSearchFormat <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the LDAP connection settings that an LDAP password type (for example LDAP (Active Directory) or LDAP (OpenLDAP)) uses to change passwords.
Only the parameters you pass are changed; the others keep their stored value.
Switch parameters send true when present; pass for example -SecureSocketLayer:$false to turn a setting off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRpcLdapSettings -TssSession $session -Id 2 -SecureSocketLayer -ProtocolVersion 3
```

Turn on SSL and LDAP protocol version 3 for LDAP connection settings 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcPasswordType -TssSession $session -Id 20 | Set-TssRpcLdapSettings -TssSession $session -UserSearchFormat '(uid=$USERNAME)'
```

Change the user search filter of the LDAP settings used by password type 20

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
LDAP connection settings ID (the LdapConnectionSettingsId property of Get-TssRpcPasswordType output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LdapConnectionSettingsId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AuthType
The authentication mechanism to use when connecting to the LDAP server.
"Basic" by default

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConvertUserToDistinguishedName
Check this to use the "User Distinguished Name Format" to determine the Distinguished Name

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

### -LookupDistinguishedNameForConnection
Use distinguished name for connection (Requires anonymous authentication and searching enabled on the domain.)

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

### -LookupDistinguishedNameForReset
Use distinguished name for reset

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

### -PasswordAttribute
By default this is "userpassword" for Open LDAP or "unicodePwd" for Active Directory, but any attribute can be entered here

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordEncodingType
Determines whether passwords are encoded for Open LDAP or Active Directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProtocolVersion
The version of the LDAP protocol to use, 3 by default

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

### -SecureSocketLayer
Use SSL

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

### -UserDistinguishedNameFormat
Ex.
(uid=$USERNAME,CN=Users,$DISTINGUISHEDDOMAINNAME).
Useful if all users are in a single location

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserNameAuthenticationFormat
Ex.
$USERNAME@$DOMAIN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserSearchFormat
Ex.
(uid=$USERNAME) or (cn=$USERNAME)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Rpc.LdapSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcLdapSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcLdapSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcLdapSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcLdapSettings.ps1)
