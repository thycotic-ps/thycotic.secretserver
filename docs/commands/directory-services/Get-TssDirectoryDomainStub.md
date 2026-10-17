---
title: Get-TssDirectoryDomainStub
parent: Directory Services
grand_parent: Commands
---
# Get-TssDirectoryDomainStub

## SYNOPSIS
Get a template for a new Directory Services domain

## SYNTAX

### Default (Default)
```
Get-TssDirectoryDomainStub [-TssSession] <Session> -DomainType <String>
 [<CommonParameters>]
```

### V2
```
Get-TssDirectoryDomainStub [-TssSession] <Session> -DomainType <String> [-V2]
 [<CommonParameters>]
```

## DESCRIPTION
Get the default values Secret Server uses for a new directory domain of the given type, such as the site, whether the domain starts active and the multifactor provider.
Nothing is created.
-V2 calls the v2 endpoint; both return the same shape.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryDomainStub -TssSession $session -DomainType ActiveDirectory
```

Show the defaults for a new Active Directory domain

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryDomainStub -TssSession $session -DomainType OpenLdap -V2
```

Show the defaults for a new OpenLDAP domain from the v2 endpoint

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DirectoryServices.DirectoryDomain
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryDomainStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryDomainStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryDomainStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryDomainStub.ps1)
