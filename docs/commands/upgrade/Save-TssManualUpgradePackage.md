---
title: Save-TssManualUpgradePackage
parent: Upgrade
grand_parent: Commands
---
# Save-TssManualUpgradePackage

## SYNOPSIS
Download a generated manual upgrade file

## SYNTAX

### Default (Default)
```
Save-TssManualUpgradePackage [-TssSession] <Session> -FileName <String> -Output <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Base64
```
Save-TssManualUpgradePackage [-TssSession] <Session> -FileName <String> -Output <String> [-Base64]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Downloads a file generated during a manual (multi-step) upgrade and writes it to the -Output folder: the SQL script (UpgradeDeltas.sql, from New-TssManualUpgradeSqlScript) or the application ZIP (ManualUpgradeFiles-MM-DD-YYYY-version.zip, from New-TssManualUpgradeAppZip).
Uses the binary download endpoint (api/v2) by default.
-Base64 uses the older api/v1 endpoint, which returns the file base64 encoded in JSON, for servers without the api/v2 endpoint.
The server accepts only those two file name shapes and fails the request for any other name.
A file that was not generated yet returns an error (404 from api/v2) and writes nothing.
Returns the saved file.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Save-TssManualUpgradePackage -TssSession $session -FileName UpgradeDeltas.sql -Output .
```

Downloads the generated SQL update script to the current folder

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$zip = New-TssManualUpgradeAppZip -TssSession $session
Save-TssManualUpgradePackage -TssSession $session -FileName $zip.FileName -Output . -Base64
```

Generates the application ZIP and downloads it through the api/v1 endpoint

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

### -FileName
File to download: UpgradeDeltas.sql, or the FileName returned by New-TssManualUpgradeAppZip

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Output
Folder to write the file to.
The file keeps its name and an existing file of that name is overwritten

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

### -Base64
Use the api/v1 endpoint, which returns the file base64 encoded in JSON

```yaml
Type: SwitchParameter
Parameter Sets: Base64
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

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Save-TssManualUpgradePackage](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Save-TssManualUpgradePackage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Save-TssManualUpgradePackage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Save-TssManualUpgradePackage.ps1)
