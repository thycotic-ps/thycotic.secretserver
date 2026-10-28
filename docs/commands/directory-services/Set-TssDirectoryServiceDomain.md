---
title: Set-TssDirectoryServiceDomain
parent: Directory Services
grand_parent: Commands
---
# Set-TssDirectoryServiceDomain

## SYNOPSIS
Update a Directory Services domain

## SYNTAX

### Default (Default)
```
Set-TssDirectoryServiceDomain [-TssSession] <Session> -Id <Int32> [-Active] [-AuthType <LdapAuthType>]
 [-ClientId <String>] [-ClientSecret <SecureString>] [-DistinguishedName <String>] [-DomainName <String>]
 [-FriendlyName <String>] [-PreventNoUsersLockout] [-MfaProvider <String>] [-SiteId <Int32>]
 [-SecretId <Int32>] [-TenantId <String>] [-UserAuthType <UserAuthType>] [-UseSecureLdap]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### V2
```
Set-TssDirectoryServiceDomain [-TssSession] <Session> -Id <Int32> [-Active] [-AuthType <LdapAuthType>]
 [-DistinguishedName <String>] [-DomainName <String>] [-FriendlyName <String>] [-PreventNoUsersLockout]
 [-MfaProvider <String>] [-SiteId <Int32>] [-SecretId <Int32>] [-UserAuthType <UserAuthType>] [-UseSecureLdap]
 [-V2] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a Directory Services domain (Active Directory, Azure AD or OpenLDAP).
Only the parameters you pass are sent; use -Active:$false or -UseSecureLdap:$false to turn a setting off.
The default parameter set calls the v1 endpoint, which also takes the Azure AD -TenantId, -ClientId and -ClientSecret.
-V2 calls the v2 endpoint, which has no Azure AD credential fields.
Activating a domain makes Secret Server validate it against the directory with the synchronization secret.
Returns the updated domain.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDirectoryServiceDomain -TssSession $session -Id 3 -FriendlyName CORP
```

Change the friendly name of domain 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectoryServiceDomain -TssSession $session -IncludeInactive | Where-Object DomainName -EQ corp.example.com | Set-TssDirectoryServiceDomain -TssSession $session -Active:$false
```

Deactivate a domain found by name

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDirectoryServiceDomain -TssSession $session -Id 3 -SecretId 42 -V2
```

Change the synchronization secret through the v2 endpoint

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
Domain ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DomainId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Make the domain active (validated against the directory) or inactive

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

### -ClientId
Azure AD application client ID (v1 only)

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
Azure AD application client secret (v1 only); never shown in Verbose or WhatIf output

```yaml
Type: SecureString
Parameter Sets: Default
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

### -DomainName
Fully qualified domain name

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

### -PreventNoUsersLockout
Refuse a synchronization that would remove every user of the domain

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: IsPreventNoUsersLockoutEnabled

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MfaProvider
Multifactor authentication provider for users of the domain

```yaml
Type: String
Parameter Sets: (All)
Aliases: MultifactorAuthenticationProvider

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Site whose engines reach the directory

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

### -SecretId
Secret used to read the directory during synchronization

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SynchronizationSecretId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Azure AD tenant ID (v1 only)

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAuthType
User authentication type (OpenLDAP): Basic, Kerberos, or NoAuthentication to clear it

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

### -V2
Call the v2 endpoint

```yaml
Type: SwitchParameter
Parameter Sets: V2
Aliases:

Required: True
Position: Named
Default value: False
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

### Thycotic.PowerShell.DirectoryServices.DirectoryServiceDomain
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Active Directory permission.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceDomain.ps1)
