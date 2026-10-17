---
title: New-TssActiveDirectoryDomain
parent: Active Directory
grand_parent: Commands
---
# New-TssActiveDirectoryDomain

## SYNOPSIS
Create a directory domain through the legacy Active Directory endpoint

## SYNTAX

```
New-TssActiveDirectoryDomain [-TssSession] <Session> -DomainType <String> -DomainName <String>
 [-FriendlyName <String>] [-Active] [-SiteId <Int32>] [-SecretId <Int32>] [-UseSecureLdap]
 [-MfaProvider <String>] [-DistinguishedName <String>] [-AuthType <LdapAuthType>]
 [-UserAuthType <UserAuthType>] [-TenantId <Guid>] [-ClientId <Guid>] [-ClientSecret <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create an Active Directory, Azure AD or OpenLDAP domain through the legacy active-directory endpoint.
New-TssDirectoryService creates the same domain through the directory-services endpoint and is the preferred cmdlet.
An active domain is validated against the directory with the synchronization secret (Azure AD: tenant, client ID and secret); create it inactive to skip that check and activate it later with Set-TssDirectoryDomain.
The response never includes the domain password, and it reports AuthType Anonymous whatever was sent: the server stores the value you pass.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssActiveDirectoryDomain -TssSession $session -DomainType ActiveDirectory -DomainName corp.example.com -FriendlyName CORP -SecretId 42 -Active
```

Create an active Active Directory domain that synchronizes with secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssActiveDirectoryDomain -TssSession $session -DomainType OpenLdap -DomainName ldap.example.com -FriendlyName LDAP -DistinguishedName 'DC=ldap,DC=example,DC=com' -AuthType Basic -SecretId 43
```

Create an inactive OpenLDAP domain

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

### -DomainType
Directory type: ActiveDirectory, OpenLdap or AzureActiveDirectory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainName
Fully qualified domain name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FriendlyName
Friendly (short) domain name, used in Discovery matching

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

### -Active
Create the domain active; Secret Server then validates it against the directory

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

### -SiteId
Site whose engines reach the directory, default 1 (the local site)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
Secret used to read the directory during synchronization

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SyncSecretId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSecureLdap
Use LDAPS

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

### -MfaProvider
Multifactor authentication provider for users of the domain, default None

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

### -DistinguishedName
Distinguished name (OpenLDAP)

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

### -AuthType
Bind authentication type (OpenLDAP): Basic, Anonymous or Kerberos

```yaml
Type: LdapAuthType
Parameter Sets: (All)
Aliases:
Accepted values: Basic, Anonymous, Kerberos

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAuthType
User authentication type (OpenLDAP): Basic, Kerberos or NoAuthentication

```yaml
Type: UserAuthType
Parameter Sets: (All)
Aliases:
Accepted values: Basic, NoAuthentication, Kerberos

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Azure AD tenant ID

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientId
Azure AD application client ID

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
Azure AD application client secret; never shown in Verbose or WhatIf output

```yaml
Type: SecureString
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

### Thycotic.PowerShell.ActiveDirectory.Domain
## NOTES
Requires TssSession object returned by New-TssSession
Secret Server marks this endpoint obsolete in favor of the directory-services endpoints; it still answers on current versions.
Requires the Administer Active Directory permission.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/New-TssActiveDirectoryDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/New-TssActiveDirectoryDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/New-TssActiveDirectoryDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/New-TssActiveDirectoryDomain.ps1)
