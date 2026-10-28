---
title: Remove-TssSecretFieldListDetail
parent: Secrets
grand_parent: Commands
---
# Remove-TssSecretFieldListDetail

## SYNOPSIS
Remove a list from a list field on a secret

## SYNTAX

```
Remove-TssSecretFieldListDetail [-TssSession] <Session> -Id <Int32> -Slug <String> [-AutoCheckIn]
 [-AutoCheckout] [-AutoComment <String>] [-ForceCheckIn] -ListId <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes one categorized list from a List type field on a secret and returns the lists still assigned to the field.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretFieldListDetail -TssSession $session -Id 42 -Slug allowed-domains -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Removes the list from the allowed-domains field of secret 42

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
Secret ID

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

### -Slug
Slug of the List type field

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AutoCheckIn
Check the secret back in after the request completes

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

### -AutoCheckout
Check out the secret automatically when it requires checkout

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

### -AutoComment
Comment to record with the automatic checkout, for secrets that require a comment

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

### -ForceCheckIn
Force check in the secret if another user has it checked out

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

### -ListId
ID (GUID) of the list to remove from the field

```yaml
Type: String
Parameter Sets: (All)
Aliases: CategorizedListId

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

### Thycotic.PowerShell.Lists.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Remove-TssSecretFieldListDetail](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Remove-TssSecretFieldListDetail)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Remove-TssSecretFieldListDetail.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Remove-TssSecretFieldListDetail.ps1)
