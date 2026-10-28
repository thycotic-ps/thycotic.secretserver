---
title: New-TssEmailHeader
parent: Configurations
grand_parent: Commands
---
# New-TssEmailHeader

## SYNOPSIS
Create a custom email message header

## SYNTAX

```
New-TssEmailHeader [-TssSession] <Session> [-Active] -HeaderName <String> -HeaderValue <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a custom header that Secret Server adds to every outgoing email.
Only the parameters you pass are sent, so omit -Active to create the header inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssEmailHeader -TssSession $session -HeaderName X-Mailer-Source -HeaderValue SecretServer -Active
```

Add the active header X-Mailer-Source: SecretServer to every outgoing email

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

### -Active
Create the header active

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

### -HeaderName
Name of the header, for example X-Mailer-Source

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

### -HeaderValue
Value of the header

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

### Thycotic.PowerShell.Configuration.EmailHeader
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/New-TssEmailHeader](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/New-TssEmailHeader)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/New-TssEmailHeader.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/New-TssEmailHeader.ps1)
