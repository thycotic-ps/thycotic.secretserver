---
title: Set-TssInternalSiteConnectorConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssInternalSiteConnectorConfiguration

## SYNOPSIS
Set the internal site connector configuration

## SYNTAX

### connector (Default)
```
Set-TssInternalSiteConnectorConfiguration [-TssSession] <Session> -SiteConnectorId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### clear
```
Set-TssInternalSiteConnectorConfiguration [-TssSession] <Session> [-Clear]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Assign the site connector Secret Server uses for its own internal traffic, or remove the assignment with -Clear.
The site connector must already exist; Secret Server answers an unknown Id with an internal server error.
Returns the configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInternalSiteConnectorConfiguration -TssSession $session -SiteConnectorId 2
```

Use site connector 2 for internal traffic

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInternalSiteConnectorConfiguration -TssSession $session -Clear
```

Remove the internal site connector assignment

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

### -SiteConnectorId
Id of the site connector Secret Server uses for internal traffic

```yaml
Type: Int32
Parameter Sets: connector
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear
Remove the internal site connector assignment

```yaml
Type: SwitchParameter
Parameter Sets: clear
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

### Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssInternalSiteConnectorConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssInternalSiteConnectorConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssInternalSiteConnectorConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssInternalSiteConnectorConfiguration.ps1)
