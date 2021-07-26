# Set-TssSecret

## SYNOPSIS
Set various settings or fields for a given secret

## SYNTAX

### all (Default)
```
Set-TssSecret [-TssSession] <Session> -Id <Int32[]> [-Comment <String>] [-ForceCheckIn] [-TicketNumber <Int32>]
 [-TicketSystemId <Int32>] [-Active] [-EnableInheritSecretPolicy] [-FolderId <Int32>] [-GenerateSshKeys]
 [-HeartbeatEnabled] [-IsOutOfSync] [-SecretName <String>] [-SecretPolicy <Int32>] [-SiteId <Int32>] [-CheckIn]
 [-AutoChangeEnabled] [-AutoChangeNextPassword <SecureString>] [-EnableInheritPermission] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### restricted
```
Set-TssSecret [-TssSession] <Session> -Id <Int32[]> [-Comment <String>] [-ForceCheckIn] [-TicketNumber <Int32>]
 [-TicketSystemId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### general
```
Set-TssSecret [-TssSession] <Session> -Id <Int32[]> [-Active] [-EnableInheritSecretPolicy] [-FolderId <Int32>]
 [-GenerateSshKeys] [-HeartbeatEnabled] [-IsOutOfSync] [-SecretName <String>] [-SecretPolicy <Int32>]
 [-SiteId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### checkIn
```
Set-TssSecret [-TssSession] <Session> -Id <Int32[]> [-CheckIn] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### put
```
Set-TssSecret [-TssSession] <Session> -Id <Int32[]> [-AutoChangeEnabled]
 [-AutoChangeNextPassword <SecureString>] [-EnableInheritPermission] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set various settings or fields for a given secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 345 -FolderId 3
```

Move Secret 345 to folder ID 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 113 -ForceCheckIn
```

Sets secret 1455 disables emailing when changed

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
Secret Id to modify

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Comment
Comment to provide for restricted secret (Require Comment is enabled)

```yaml
Type: String
Parameter Sets: all, restricted
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceCheckIn
Force check-in of the Secret

```yaml
Type: SwitchParameter
Parameter Sets: all, restricted
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketNumber
Associated Ticket Number

```yaml
Type: Int32
Parameter Sets: all, restricted
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketSystemId
Associated Ticket System ID

```yaml
Type: Int32
Parameter Sets: all, restricted
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Set the secret active secret is active

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableInheritSecretPolicy
Whether Secret Policy is inherited from containing folder

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Folder (ID)

```yaml
Type: Int32
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateSshKeys
Generate new SSH Keys

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatEnabled
Heartbeat enabled

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsOutOfSync
Secret out of sync

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretName
Secret name

```yaml
Type: String
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPolicy
Secret Policy (ID)

```yaml
Type: Int32
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Secret Site

```yaml
Type: Int32
Parameter Sets: all, general
Aliases: Site

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CheckIn
Check-In a Secret, can be combined with ForceCheckIn to forcibly check the Secret in

```yaml
Type: SwitchParameter
Parameter Sets: all, checkIn
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoChangeEnabled
Set Auto Change Enabled

```yaml
Type: SwitchParameter
Parameter Sets: all, put
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoChangeNextPassword
Set the password to use on next Auto Change

```yaml
Type: SecureString
Parameter Sets: all, put
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableInheritPermission
Set Inherit Permission on the Secret

```yaml
Type: SwitchParameter
Parameter Sets: all, put
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecret.ps1)

