---
title: Remove-TssPasswordDictionary
parent: Secret Templates
grand_parent: Commands
---
# Remove-TssPasswordDictionary

## SYNOPSIS
Remove a custom password dictionary

## SYNTAX

```
Remove-TssPasswordDictionary [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a custom password dictionary and its items.
A dictionary that a password requirement uses is not deleted: IsDeleted is false and InUsePasswordRequirements names the requirements that use it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssPasswordDictionary -TssSession $session -Id 3
```

Deletes password dictionary 3, unless a password requirement uses it

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
Password dictionary ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: DictionaryId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.SecretTemplates.PasswordDictionaryDelete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssPasswordDictionary](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssPasswordDictionary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssPasswordDictionary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssPasswordDictionary.ps1)
