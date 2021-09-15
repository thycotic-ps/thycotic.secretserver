# New-TssDirectoryService

## SYNOPSIS
Create a new Directory Service for Active Direcotry, AzureAD or OpenLDAP

## SYNTAX

### openldap
```
New-TssDirectoryService [-TssSession] <Session> [-Active] -DomainName <String> -FriendlyName <String>
 [-SiteId <Int32>] [-UseSecureLdap] [-MfaProvider <MfaProviderType>] [-SecretId <Int32>]
 -DistinguishedName <String> -AuthType <LdapAuthType> -UserAuthType <UserAuthType> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### azure
```
New-TssDirectoryService [-TssSession] <Session> [-Active] -DomainName <String> [-SiteId <Int32>]
 [-MfaProvider <MfaProviderType>] -TenantId <String> -ClientId <String> -ClientSecret <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### active-directory
```
New-TssDirectoryService [-TssSession] <Session> [-Active] -DomainName <String> -FriendlyName <String>
 [-SiteId <Int32>] [-UseSecureLdap] [-MfaProvider <MfaProviderType>] -SecretId <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new Directory Service for Active Direcotry, AzureAD or OpenLDAP

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newDomain = @{
    TssSession = $session
    Active = $true
    DomainName = 'lab.local'
    FriendlyName = 'lab'
    SecretId = 1064
}
New-TssDirectoryService @newDomain
```

Create a new Active Directory Domain Directory Service

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newDomain = @{
    TssSession = $session
    Active = $true
    DomainName = 'lab.onmicrosoft.com'
    TenantId = '1dcfeb09-1600-4865-a4db-738ceab78d3d'
    ClientSecret = 'p857Q~fChrIsRkG0Pin3mUfHH3tAnp1W2RHOz'
    SecretId = 1064
}
New-TssDirectoryService @newDomain
```

Create a new Azure Active Directory tenant Directory Service

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

### -Active
Active on creation

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

### -DomainName
Domain Name, FQDN

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
Domain Friendly Name (short name, will be used in Discovery matching)

```yaml
Type: String
Parameter Sets: openldap, active-directory
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Site ID, default local/default site (1)

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

### -UseSecureLdap
Use Secure LDAP

```yaml
Type: SwitchParameter
Parameter Sets: openldap, active-directory
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MfaProvider
MFA Provider, default None

```yaml
Type: MfaProviderType
Parameter Sets: (All)
Aliases:
Accepted values: None, Radius, TOTPAuthenticator, Duo, Fido2, Email

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
Secret used for synchronization

```yaml
Type: Int32
Parameter Sets: openldap
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: active-directory
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Tenant ID

```yaml
Type: String
Parameter Sets: azure
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientId
Client ID

```yaml
Type: String
Parameter Sets: azure
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
Client Secret

```yaml
Type: String
Parameter Sets: azure
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DistinguishedName
Distinguished Name

```yaml
Type: String
Parameter Sets: openldap
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthType
Authentication type

```yaml
Type: LdapAuthType
Parameter Sets: openldap
Aliases:
Accepted values: Basic, Anonymous, Kerberos

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAuthType
User Authentication type (only AuthType=Anonymous)

```yaml
Type: UserAuthType
Parameter Sets: openldap
Aliases:
Accepted values: Basic, NoAuthentication, Kerberos

Required: True
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

### Thycotic.PowerShell.DirectoryServices.Domain
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/New-TssDirectoryService](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/New-TssDirectoryService)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/New-TssDirectoryService.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/New-TssDirectoryService.ps1)

