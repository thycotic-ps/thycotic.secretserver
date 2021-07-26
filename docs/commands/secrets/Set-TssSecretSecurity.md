# Set-TssSecretSecurity

## SYNOPSIS
Set Secret general security options

## SYNTAX

```
Set-TssSecretSecurity [-TssSession] <Session> -Id <Int32[]> [-DoubleLockId <Int32>] [-HideLauncherPassword]
 [-ProxyEnabled] [-RequiresComment] [-SessionRecordingEnabled] [-WebLauncherRequiresIncognitoMode] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set Secret general security options

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretSecurity -TssSession $session -Id 42
```

DOING something

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
Folder Id to modify

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

### -DoubleLockId
DoubleLock to associate to the secret

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

### -HideLauncherPassword
Hide the launcher password from non-owners (Viewing Password Requires Edit in UI)

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

### -ProxyEnabled
Enable proxy on the Secret

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

### -RequiresComment
Require comment to view the Secret

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

### -SessionRecordingEnabled
Enable Session Recording for the Secret

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

### -WebLauncherRequiresIncognitoMode
Require Web Launcher to be incognito mode for the Secret

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretSecurity](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretSecurity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretSecurity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretSecurity.ps1)

