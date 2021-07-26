# Get-TssGroupUser

## SYNOPSIS
Get a user in a Group

## SYNTAX

```
Get-TssGroupUser [-TssSession] <Session> -Id <Int32> -UserId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get a user in a Group

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupUser -TssSession $session -Id 8 -UserId 43
```

Get User Id 43 details in Group ID 8

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
Group ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserId
User ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Groups.User
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupUser.ps1)

