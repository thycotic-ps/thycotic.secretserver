# Search-TssRole

## SYNOPSIS
Search Roles

## SYNTAX

### user (Default)
```
Search-TssRole [-TssSession] <Session> [-UserId <Int32>] [-IncludeInactive] [-SortBy <String>]
 [<CommonParameters>]
```

### group
```
Search-TssRole [-TssSession] <Session> [-GroupId <Int32>] [-IncludeInactive] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search Roles

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRole -TssSession $session -UserId 43
```

Returns roles assigned to User ID 43

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
Only return roles assigned to this User ID

```yaml
Type: Int32
Parameter Sets: user
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupId
Only return roles assigned to this Group ID

```yaml
Type: Int32
Parameter Sets: group
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive roles in the results

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

### -SortBy
Sort by specific property, default Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Name
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Roles.Role
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRole.ps1)

