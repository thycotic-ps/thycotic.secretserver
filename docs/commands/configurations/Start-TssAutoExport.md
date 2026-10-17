---
title: Start-TssAutoExport
parent: Configurations
grand_parent: Commands
---
# Start-TssAutoExport

## SYNOPSIS
Run the automatic export now

## SYNTAX

```
Start-TssAutoExport [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts the automatic export now, using the current automatic export configuration (see Get-TssConfigurationAutoExport).
Returns True when Secret Server queued the export.
When automatic export is disabled Secret Server refuses the request with HTTP 500 and errorCode API_ConfigurationNotEnabled: the cmdlet writes an error, returns nothing and no export runs.
On-prem the error text is API_ConfigurationNotEnabled; on Secret Server Cloud it can read only Internal Server Error.
Enable it first with Set-TssConfigurationAutoExport -Enable.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssAutoExport -TssSession $session
```

Run the automatic export now

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssAutoExport](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssAutoExport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssAutoExport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssAutoExport.ps1)
