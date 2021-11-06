# Clear-TssList

## SYNOPSIS
Clear all List categories and options from the list.

## SYNTAX

```
Clear-TssList [-TssSession] <Session> -Id <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clear all List categories and options from the list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssList -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
```

Clear all the options from the provided List Id, will prompt to confirm the action since it is not reversible

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssList -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0 -Confirm:$false
```

Clear all the options from the provided List Id, will **not** prompt to confirm the action since it is not reversible

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
Categorized List ID

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CategorizedListId

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Clear-TssList](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Clear-TssList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Clear-TssList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Clear-TssList.ps1)

