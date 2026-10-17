---
title: New-TssInboxRuleCondition
parent: Inbox Rules
grand_parent: Commands
---
# New-TssInboxRuleCondition

## SYNOPSIS
Add a condition to an inbox rule

## SYNTAX

```
New-TssInboxRuleCondition [-TssSession] <Session> -InboxRuleId <Int32> -InboxDataId <Int32> [-Operand <String>]
 [-ValueString <String>] [-ValueInt <Int32>] [-ValueBool <Boolean>] [-ValueDateTime <DateTime>]
 [-DisplayValue <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add a condition to an inbox rule: the rule then only fires for messages whose data value (InboxDataId) compares true against the given value.
Set the value parameter that matches the data type (ValueString, ValueInt, ValueBool or ValueDateTime).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -InboxDataId 2 -Operand Equals -ValueString 'Production' -DisplayValue 'Production'
```

Make inbox rule 7 fire only for messages whose data value 2 equals Production

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

### -InboxRuleId
Inbox rule ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InboxDataId
Inbox data ID the condition tests (InboxDataId from Search-TssInboxDataName)

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

### -Operand
Comparison operator (default Equals)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Equals
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueString
String value to compare with

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

### -ValueInt
Integer value to compare with

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

### -ValueBool
Boolean value to compare with

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueDateTime
Date value to compare with

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayValue
Display text of the value

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

### Thycotic.PowerShell.InboxRules.Condition
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRuleCondition](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRuleCondition)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRuleCondition.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRuleCondition.ps1)
