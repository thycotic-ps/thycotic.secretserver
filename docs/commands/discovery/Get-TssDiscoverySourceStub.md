---
title: Get-TssDiscoverySourceStub
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySourceStub

## SYNOPSIS
Get the default settings of a new discovery source

## SYNTAX

```
Get-TssDiscoverySourceStub [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a discovery source populated with the default values of a source type, as a starting point for a new source.
Nothing is created.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySourceStub -TssSession $session -Id 6
```

Get the default settings of a new Active Directory discovery source

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
Discovery source type ID: 1 Unix, 2 ODBC, 3 FileLoad, 4 ManualInput, 5 ESX, 6 ActiveDirectory, 7 PowerShell, 9 AmazonWebService, 10 GoogleCloudProvider, 11 EntraId

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TypeId

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

### Thycotic.PowerShell.Discovery.Source
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceStub.ps1)
