---
title: Copy-TssSecretTemplate
parent: Secret Templates
grand_parent: Commands
---
# Copy-TssSecretTemplate

## SYNOPSIS
Copy a secret template

## SYNTAX

```
Copy-TssSecretTemplate [-TssSession] <Session> -Id <Int32> -Name <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new secret template that duplicates an existing template, including its fields.
Use -Name to name the copy; Secret Server requires a name.
Returns the detail of the new template, including its ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Copy-TssSecretTemplate -TssSession $session -Id 6001 -Name 'Windows Account (Ops)'
```

Copy template 6001 to a new template named Windows Account (Ops)

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
Secret template ID to copy

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

### -Name
Name of the new template

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

### Thycotic.PowerShell.SecretTemplates.Detail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Copy-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Copy-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Copy-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Copy-TssSecretTemplate.ps1)
