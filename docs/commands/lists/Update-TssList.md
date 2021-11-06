# Update-TssList

## SYNOPSIS
Update a given list

## SYNTAX

```
Update-TssList [-TssSession] <Session> -List <List[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a given list

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$list = Get-TssList -TssSession -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
$list.Active = $false
Update-TssList -TssSession $session  -List $list
```

Disable the provided List ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$list = Get-TssList -TssSession -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
$list.Active = $true
Update-TssList -TssSession $session -List $list
```

Enable the provided List ID

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$lists = Search-TssList -TssSession $session -SearchText URL | Get-TssList -TssSession
$lists.Description = 'Testing URL List'
Update-TssList -TssSession $session -List $list
```

Update the Description on all Lists that have "URL" in their name

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

### -List
Categorized List Object (output via Get-TssList)

```yaml
Type: List[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Lists.List
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssList](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssList.ps1)

