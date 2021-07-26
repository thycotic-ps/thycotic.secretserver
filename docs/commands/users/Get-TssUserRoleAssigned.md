# Get-TssUserRoleAssigned

## SYNOPSIS
Get roles assigned to User Id

## SYNTAX

```
Get-TssUserRoleAssigned [-TssSession] <Session> -UserId <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get roles assigned to User Id

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserRoleAssigned -TssSession $session -UserId 254
```

Returns roles assigned to the User ID 254

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

### -UserId
User ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Users.UserRoleSummary
## NOTES
Requires TssSession object returned by New-TssSession
Only supported on 10.9.32 or higher of Secret Server

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserRoleAssigned.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserRoleAssigned.ps1)

