---
title: Import-TssSecretCsv
parent: Secrets
grand_parent: Commands
---
# Import-TssSecretCsv

## SYNOPSIS
Import secrets from CSV

## SYNTAX

### Default (Default)
```
Import-TssSecretCsv [-TssSession] <Session> -TemplateId <Int32> -Csv <String> [-AllowDuplicateSecrets]
 [-ImportWithFolder] [-ImportWithTotp] [-ChangeRemotePasswords] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Verify
```
Import-TssSecretCsv [-TssSession] <Session> -TemplateId <Int32> -Csv <String> [-AllowDuplicateSecrets]
 [-ImportWithFolder] [-ImportWithTotp] [-Verify] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Imports secrets of one secret template from CSV text.
The import runs in the background; the TaskIdentifier of the import and any errors are returned.
-Verify checks the CSV without importing and returns the parsed rows and errors.
The CSV has no header row: each line is one secret, with the secret name first, then the template field values in template field order, then the folder when -ImportWithFolder is set, then the TOTP values when -ImportWithTotp is set.
A header line is imported as a secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssSecretCsv -TssSession $session -TemplateId 6003 -Csv (Get-Content -Path ./secrets.csv -Raw) -Verify
```

Checks secrets.csv against template 6003 without importing

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssSecretCsv -TssSession $session -TemplateId 6003 -Csv (Get-Content -Path ./secrets.csv -Raw) -ImportWithFolder
```

Imports secrets.csv into template 6003, placing each secret in the folder named in its Folder column

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

### -TemplateId
Secret template ID of the secrets to import

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Csv
CSV text without a header row, one secret per line: secret name, the template field values in template field order, then the folder and TOTP values when those switches are set

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

### -AllowDuplicateSecrets
Import rows that duplicate existing secrets

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

### -ImportWithFolder
Each line has a folder column, after the template field values, with the folder of the secret

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

### -ImportWithTotp
Each line ends with the TOTP values

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

### -ChangeRemotePasswords
Change the imported passwords on the remote systems

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Verify
Check the CSV without importing (POST api/v1/secrets/import-csv-verify); returns the parsed rows and errors

```yaml
Type: SwitchParameter
Parameter Sets: Verify
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

### Thycotic.PowerShell.Secrets.CsvImport
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretCsv](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretCsv)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretCsv.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretCsv.ps1)
