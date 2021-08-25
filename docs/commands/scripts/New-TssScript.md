# New-TssScript

## SYNOPSIS
Create a new Script

## SYNTAX

```
New-TssScript [-TssSession] <Session> -Name <String> -Description <String> -Type <ScriptType>
 [-Category <ScriptCategory>] -Script <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new Script

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssScript -TssSession $session -Name 'PS Script One' -Description 'Testing new script function' -Type PowerShell -Script 'throw whoami'
```

Create a PowerShell script

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
Script name

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

### -Description
Description

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

### -Type
Script type (PowerShell, SQL, SSH)

```yaml
Type: ScriptType
Parameter Sets: (All)
Aliases:
Accepted values: PowerShell, SQL, SSH

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
Script Category (Untyped, TicketValidation, TicketComment, SecretDiscovery,
   Heartbeat, PasswordChanging, DiscoveryTakeover, Dependency)

```yaml
Type: ScriptCategory
Parameter Sets: (All)
Aliases:
Accepted values: Untyped, TicketValidation, TicketComment, SecretDiscovery, Heartbeat, PasswordChanging, DiscoveryTakeover, Dependency

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Script
Script content

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

### Thycotic.PowerShell.Scripts.Script
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssScript.ps1)

