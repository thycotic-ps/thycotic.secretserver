---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Enable-TssSecretCheckOut
schema: 2.0.0
title: Enable-TssSecretCheckOut
---

# Enable-TssSecretCheckOut

## SYNOPSIS
Enable various properties for a given SecretCheckOut

## SYNTAX

### all (Default)
```
Enable-TssSecretCheckOut [-TssSession] <TssSession> -Id <Int32[]> -CheckoutInterval <Int32>
 [-ChangePasswordOnCheckIn] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### checkout
```
Enable-TssSecretCheckOut [-TssSession] <TssSession> -Id <Int32[]> -CheckoutInterval <Int32>
 [-ChangePasswordOnCheckIn] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enable various properties for a given SecretCheckOut

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Enable-TssSecretCheckOut -TssSession $session -Id 36
```

Enable checkout on Secret 36

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Secret Id to modify

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

### -CheckoutInterval
Checkout Interval in Minutes (default 10 minutes)

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

### -ChangePasswordOnCheckIn
Enable Change Password on Check In

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Enable-TssSecretCheckOut](https://thycotic-ps.github.io/thycotic.secretserver/commands/Enable-TssSecretCheckOut)

