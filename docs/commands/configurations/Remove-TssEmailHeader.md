---
title: Remove-TssEmailHeader
parent: Configurations
grand_parent: Commands
---
# Remove-TssEmailHeader

## SYNOPSIS
Remove a custom email message header

## SYNTAX

```
Remove-TssEmailHeader [-TssSession] <Session> -Id <String[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a custom email message header by Id.
Returns whether the delete succeeded.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEmailHeader -TssSession $session | Where-Object HeaderName -EQ X-Mailer-Source | Remove-TssEmailHeader -TssSession $session
```

Remove the X-Mailer-Source header

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
Id (GUID) of the email header

```yaml
Type: String[]
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

### Thycotic.PowerShell.Configuration.EmailHeaderDeleteResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssEmailHeader](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssEmailHeader)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssEmailHeader.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssEmailHeader.ps1)
