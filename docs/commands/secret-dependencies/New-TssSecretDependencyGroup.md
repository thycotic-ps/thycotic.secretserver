# New-TssSecretDependencyGroup

## SYNOPSIS
Create a new Dependency Group on a Secret

## SYNTAX

```
New-TssSecretDependencyGroup [-TssSession] <Session> -Id <Int32[]> -GroupName <String> [-SiteId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new Dependency Group on a Secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential (Get-Secret apiacct)
New-TssSecretDependencyGroup -TssSession $session -Id 330, 342 -GroupName 'QA Env'
```

Create the Dependency Group "QA Env" on Secrets 330 and 342

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential (Get-Secret apiacct)
Search-TssSecret -TssSession $session -FolderId 50 | New-TssSecretDependencyGroup -TssSession $session -GroupName 'Test Env'
```

Create the Dependency Group "Test Env" on all Secrets found under Folder ID 50, that the apiacct has access

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupName
Name of Group

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

### -SiteId
Site ID, not provided will configure "Site from Secret"

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

### Thycotic.PowerShell.SecretDependencies.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/New-TssSecretDependencyGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/New-TssSecretDependencyGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/New-TssSecretDependencyGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/New-TssSecretDependencyGroup.ps1)

