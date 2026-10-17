---
title: Set-TssDcm
parent: Configurations
grand_parent: Commands
---
# Set-TssDcm

## SYNOPSIS
Set the Delinea Credential Manager configuration

## SYNTAX

```
Set-TssDcm [-TssSession] <Session> [-Autofill] [-AutoSubmit] [-CustomTemplateIds <Int32[]>] [-InlinePopup]
 [-PromptToSave] [-PromptToUpdate] [-TemplateConfiguration <String>] -Type <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the Delinea Credential Manager (browser extension) configuration for business users or unrestricted users and returns the updated configuration.
Secret Server applies -Type BusinessUser to the business user configuration only for a session authenticated through Delinea Platform; with any other session it updates the unrestricted user configuration instead.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Autofill:$false turns autofill off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDcm -TssSession $session -Type UnrestrictedUser -Autofill -AutoSubmit:$false
```

Unrestricted users get autofill without automatic form submit

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDcm -TssSession $session -Type UnrestrictedUser -TemplateConfiguration Custom -CustomTemplateIds 6001, 6003
```

Unrestricted users are offered only secret templates 6001 and 6003

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

### -Autofill
Fill matching login forms automatically

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

### -AutoSubmit
Submit the login form after filling it

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

### -CustomTemplateIds
Secret template ids the extension offers when -TemplateConfiguration is Custom

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InlinePopup
Use the inline popup

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

### -PromptToSave
Offer to save a new secret after a login

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

### -PromptToUpdate
Offer to update the secret after a change

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

### -TemplateConfiguration
Secret templates the extension offers: Default, All, or Custom (the -CustomTemplateIds list)

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

### -Type
Configuration to update: BusinessUser or UnrestrictedUser.
BusinessUser needs a session authenticated through Delinea Platform; with any other session Secret Server updates the unrestricted user configuration

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

### Thycotic.PowerShell.Configuration.Dcm
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssDcm](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssDcm)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssDcm.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssDcm.ps1)
