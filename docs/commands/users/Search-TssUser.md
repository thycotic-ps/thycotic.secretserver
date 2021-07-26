# Search-TssUser

## SYNOPSIS
Search for a Secret Server user

## SYNTAX

```
Search-TssUser [-TssSession] <Session> [-DomainId <Int32>] [-IncludeInactive] [-Field <String[]>]
 [-SearchText <String>] [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search for a Secret Server User

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUser -TssSession $session -DomainId 2
```

Return a list of all users assigned to Domain ID 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUser -TssSession $session -Field Username,Email -SearchText demo
```

Return a list of all users with "demo" in the username or email

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

### -DomainId
Filter users by Active Directory Domain

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Domain

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive users in results

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

### -Field
User field(s) to search

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: SearchFields

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Search text

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

### -SortBy
Sort by specific property, default DisplayName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: DisplayName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Users.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUser.ps1)

