---
title: Import-TssDiscoveryAccountRule
parent: Discovery
grand_parent: Commands
---
# Import-TssDiscoveryAccountRule

## SYNOPSIS
Import discovered accounts as secrets

## SYNTAX

```
Import-TssDiscoveryAccountRule [-TssSession] <Session> [-ChangePassword] -DiscoverySourceId <Int32>
 [-FolderId <Int32>] -ItemId <Int32[]> [-NextPassword <SecureString>] [-Passphrase <SecureString>]
 [-Password <SecureString>] [-PrivateKey <SecureString>] [-RandomPassword] -ScanItemTemplateId <Int32>
 -SecretNameFormat <String> [-SecretPrivilegedAccount <Int32[]>] -SecretTypeId <Int32> -SiteId <Int32>
 [-TakeOverAccountPasswordTypeId <Int32>] [-TakeOverAccountSecrets <Int32[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a bulk operation that creates secrets for the discovered accounts passed in ItemId, the same import Discovery account rules run.
Returns the bulk operation id.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssDiscoveryAccountRule -TssSession $session -ItemId 118, 119 -DiscoverySourceId 2 -ScanItemTemplateId 1 -SecretTypeId 6007 -FolderId 12 -SecretNameFormat '$MACHINE\$USERNAME' -SiteId 1
```

Create secrets named after the machine and account in folder 12, on site 1, for discovered accounts 118 and 119

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

### -ChangePassword
Change the account password on import

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

### -DiscoverySourceId
Discovery source of the accounts

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

### -FolderId
Folder where created secrets go

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

### -ItemId
Discovered computer account ids to import

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NextPassword
New password to set when changing it without RandomPassword

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passphrase
Passphrase of the private key

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Current account password to store in created secrets

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateKey
Current private key to store in created secrets

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RandomPassword
Generate a random password when changing it

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

### -ScanItemTemplateId
Scan template of the accounts

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

### -SecretNameFormat
Pattern used to name created secrets: $ followed by a secret template field name is replaced by that field value, for example $MACHINE\$USERNAME.
Required because the server fails every item of an import without it.

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

### -SecretPrivilegedAccount
Secret ids of privileged accounts used to change passwords, empty when not given

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

### -SecretTypeId
Secret template id used for created secrets

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

### -SiteId
Site used for created secrets.
Required because the server fails every item of an import without it.

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

### -TakeOverAccountPasswordTypeId
Password type id used for takeover

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

### -TakeOverAccountSecrets
Secret ids of accounts used for takeover, empty when not given

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

### Thycotic.PowerShell.Discovery.BulkOperation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryAccountRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryAccountRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryAccountRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryAccountRule.ps1)
