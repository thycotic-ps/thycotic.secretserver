# Get-TssUserRole

## SYNOPSIS
Get roles for a user

## SYNTAX

```
Get-TssUserRole [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get roles for a user

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserRole -TssSession $session -Id 2
```

Get assigned roles for User ID 2

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
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

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

### Thycotic.PowerShell.Users.RoleSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserRole.ps1)

