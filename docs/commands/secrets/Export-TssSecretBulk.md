---
title: Export-TssSecretBulk
parent: Secrets
grand_parent: Commands
---
# Export-TssSecretBulk

## SYNOPSIS
Export secrets in bulk

## SYNTAX

### Default (Default)
```
Export-TssSecretBulk [-TssSession] <Session> -FolderId <Int32> [-ExportChildFolders] [-ExportFolderPath]
 [-ExportTemplateName] [-ExportTotp] [-FileType <String>] [-Notes <String>] -Password <SecureString>
 [-DoubleLockPassword <SecureString>] [<CommonParameters>]
```

### Job
```
Export-TssSecretBulk [-TssSession] <Session> -FolderId <Int32> [-ExportChildFolders] [-ExportFolderPath]
 [-ExportTemplateName] [-ExportTotp] [-FileType <String>] [-Notes <String>] -Password <SecureString>
 [-DoubleLockPassword <SecureString>] [-Job] [<CommonParameters>]
```

## DESCRIPTION
Exports the secrets of a folder to CSV or XML.
By default the export runs synchronously and the file text is returned in ExportedSecretsFileText.
-Job starts an export job instead and returns its ExportJobId; read its status and file with Get-TssSecretBulkExport.
Secret Server asks for the login password of the current user again before an export: pass it as -Password.
Secrets protected by DoubleLock also need -DoubleLockPassword.
The user needs View on every secret in scope.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$password = Read-Host -AsSecureString
(Export-TssSecretBulk -TssSession $session -FolderId 7 -ExportChildFolders -ExportFolderPath -Password $password).ExportedSecretsFileText | Set-Content -Path ./secrets.csv
```

Exports folder 7 and its child folders to secrets.csv

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$password = Read-Host -AsSecureString
$job = Export-TssSecretBulk -TssSession $session -FolderId -1 -ExportChildFolders -FileType Xml -Password $password -Job
$job | Get-TssSecretBulkExport -TssSession $session -Status
```

Starts an XML export job of every folder and checks its status

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

### -FolderId
Folder ID to export.
Use -1 for the root folder

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

### -ExportChildFolders
Include the secrets of child folders

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

### -ExportFolderPath
Add the folder path of each secret to the export

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

### -ExportTemplateName
Add the secret template name of each secret to the export

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

### -ExportTotp
Include TOTP settings

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

### -FileType
File format of the export, Csv or Xml

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

### -Notes
Note recorded with the export

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

### -Password
Login password of the current user; Secret Server asks for it again before an export

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoubleLockPassword
DoubleLock password, needed when secrets in scope are protected by DoubleLock

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

### -Job
Start an export job (POST api/v2/secrets/export/job) instead of the synchronous export; returns the ExportJobId

```yaml
Type: SwitchParameter
Parameter Sets: Job
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

### Thycotic.PowerShell.Secrets.BulkExport
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Export-TssSecretBulk](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Export-TssSecretBulk)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Export-TssSecretBulk.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Export-TssSecretBulk.ps1)
