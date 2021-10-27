# New-TssUser

## SYNOPSIS
Create a new Secret Server User

## SYNTAX

```
New-TssUser [-TssSession] <Session> -Username <String> -DisplayName <String> -Password <SecureString> [-Active]
 [-IsApplicationAccount] [-EmailAddress <String>] [-DomainId <Int32>] [-AdGuid <String>]
 [-TwoFactorType <TwoFactorTypes>] [-RadiusUsername <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new Secret Server User

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
New-TssUser -TssSession $session -Username 'testuser' -DisplayName 'My Test User' -Password (ConvertTo-SecureString 'pass!' -AsPlainText -Force) -Active
```

Create testuser with a DisplayName of "My Test User", and enable on creation.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
New-TssUser -TssSession $session -Username 'apiuser' -DisplayName 'Dev Test App User' -Password (ConvertTo-SecureString 'pass$' -AsPlainText -Force) -IsApplicationAccount -Active
```

Create apiuser as an Application Account and enable on creation.

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

### -Username
Username

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DisplayName
Display Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Password
Password (for local only)

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Enable the account on creation

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

### -IsApplicationAccount
Create as an application account

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

### -EmailAddress
Email address

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

### -DomainId
Active Directory Domain ID

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

### -AdGuid
Active Directory GUID

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

### -TwoFactorType
2FA type (DUO, FIDO, RADIUS, OATH)

```yaml
Type: TwoFactorTypes
Parameter Sets: (All)
Aliases:
Accepted values: DUO, FIDO, RADIUS, OATH

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RadiusUsername
Username for RADIUS

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

### Thycotic.PowerShell.Users.User
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUser.ps1)

