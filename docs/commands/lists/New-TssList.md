# New-TssList

## SYNOPSIS
Create a new List

## SYNTAX

```
New-TssList [-TssSession] <Session> -Name <String> [-Description <String>] [-Active] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new List

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssList -TssSession $session -Name 'My New List' -Active
```

Creates a new List named "My New List" and Actives it upon creation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssList -TssSession $session -Name 'My New List' -Active:$false
```

Creates a new List named "My New List" and disabling it upon creation

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
List Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Description
List Description

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

### -Active
Activate the List on creation

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

### Thycotic.PowerShell.Lists.List
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssList](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssList.ps1)

