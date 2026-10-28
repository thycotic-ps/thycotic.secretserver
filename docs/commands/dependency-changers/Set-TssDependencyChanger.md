---
title: Set-TssDependencyChanger
parent: Dependency Changers
grand_parent: Commands
---
# Set-TssDependencyChanger

## SYNOPSIS
Update a dependency changer

## SYNTAX

```
Set-TssDependencyChanger [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>]
 [-DependencyTypeId <Int32>] [-ScanItemTemplateId <Int32>] [-Active] [-Setting <Object[]>]
 [-PasswordChangeScript <Object>] [-VerificationScript <Object>] [-ChangeSuccessScript <Object>]
 [-ChangeFailScript <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the given fields of a dependency changer; fields you do not pass stay as they are.
Built-in changers, and changers used by a system dependency template, cannot be edited: the server returns HTTP 400.
The request body is not written to Verbose or ShouldProcess output because script slots can carry credentials.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDependencyChanger -TssSession $session -Id 42 -Description 'Changer for the web farm'
```

Change the description of dependency changer 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDependencyChanger -TssSession $session -Id 42 -Active:$false
```

Retire dependency changer 42 (there is no delete endpoint)

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
Dependency changer ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyChangerId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New name

```yaml
Type: String
Parameter Sets: (All)
Aliases: SecretDependencyChangerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
New description

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
New dependency type ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyTypeId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanItemTemplateId
New discovery scan template ID

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

### -Active
Make the changer active (-Active) or inactive (-Active:$false)

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
Replacement settings: objects or hashtables with settingName and value

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordChangeScript
Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = \<value\> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }.
This slot cannot be removed: a script changer must keep a password change script, so a scriptId of $null returns HTTP 400 (passwordChangeScript is required) and the slot stays.
The server applies the slot only when scriptId or arguments is dirty, then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

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
Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = \<value\> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }.
The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

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
Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = \<value\> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }.
The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

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
Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = \<value\> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }.
The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Set-TssDependencyChanger](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Set-TssDependencyChanger)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Set-TssDependencyChanger.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Set-TssDependencyChanger.ps1)
