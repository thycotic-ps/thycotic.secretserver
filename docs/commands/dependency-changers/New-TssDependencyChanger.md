---
title: New-TssDependencyChanger
parent: Dependency Changers
grand_parent: Commands
---
# New-TssDependencyChanger

## SYNOPSIS
Create a dependency changer

## SYNTAX

```
New-TssDependencyChanger [-TssSession] <Session> -Name <String> [-Description <String>]
 -DependencyTypeId <Int32> -ScanItemTemplateId <Int32> [-Active] [-CreateDependencyTemplate]
 -Setting <Object[]> [-PasswordChangeScript <Object>] [-VerificationScript <Object>]
 [-ChangeSuccessScript <Object>] [-ChangeFailScript <Object>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a dependency changer.
The server rejects an empty setting list; list the settings with Search-TssDependencyChangerSetting.
There is no delete endpoint for dependency changers: set -Active to false with Set-TssDependencyChanger to retire one.
The request body is not written to Verbose or ShouldProcess output because script slots can carry credentials.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDependencyChanger -TssSession $session -Name 'App Pool Changer' -DependencyTypeId 1 -ScanItemTemplateId 11 -Setting @{ settingName = 'WaitBeforeSeconds'; value = '5' } -Active
```

Create an active Application Pool dependency changer that waits five seconds before it runs

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

### -Name
Dependency changer name

```yaml
Type: String
Parameter Sets: (All)
Aliases: SecretDependencyChangerName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Dependency changer description

```yaml
Type: String
Parameter Sets: (All)
Aliases: SecretDependencyChangerDescription

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DependencyTypeId
Dependency type ID (see SecretDependencyTypeId on Search-TssDependencyChanger output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanItemTemplateId
Discovery scan template ID the changer applies to

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

### -Active
Make the changer active

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

### -CreateDependencyTemplate
Also create a matching dependency template

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

### -Setting
Changer settings: objects or hashtables with settingName and value, for example @{ settingName = 'WaitBeforeSeconds'; value = '0' }.
The Settings of Get-TssDependencyChanger output can be passed as they are

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordChangeScript
Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VerificationScript
Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangeSuccessScript
Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangeFailScript
Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
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

### Thycotic.PowerShell.DependencyChangers.DependencyChanger
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/New-TssDependencyChanger](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/New-TssDependencyChanger)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/New-TssDependencyChanger.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/New-TssDependencyChanger.ps1)
