---
title: Import-TssSecretXml
parent: Secrets
grand_parent: Commands
---
# Import-TssSecretXml

## SYNOPSIS
Import secrets from Secret Server XML

## SYNTAX

```
Import-TssSecretXml [-TssSession] <Session> [-ChangeRemotePasswords] [-ImportWithFolder]
 [-InheritFolderPermissions] -Xml <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts an import of secrets from XML in the Secret Server export format.
Secret Server imports in the background and returns the task identifier.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$xml = Get-Content -Path ./secrets-export.xml -Raw
Import-TssSecretXml -TssSession $session -Xml $xml -ImportWithFolder
```

Imports the secrets in secrets-export.xml, creating their folders

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

### -ChangeRemotePasswords
Change the passwords on the remote systems after import

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
Create the folders named in the XML

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

### -InheritFolderPermissions
Imported secrets inherit permissions from their folder

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

### -Xml
XML to import, in the Secret Server export format

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

### Thycotic.PowerShell.Secrets.XmlImport
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretXml](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretXml)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretXml.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretXml.ps1)
