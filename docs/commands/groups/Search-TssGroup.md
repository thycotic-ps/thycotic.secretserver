# Search-TssGroup

## SYNOPSIS
Search for user management groups

## SYNTAX

```
Search-TssGroup [-TssSession] <Session> [-DomainId <Int32>] [-IncludeInactive] [-SearchText <String>]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search for user management groups

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssGroup -TssSession $session
```

Return list of all groups found in Secret Server that account has access to manage

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
Active Directory Domain Id

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

### -IncludeInactive
Include inactive groups in results

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

### -SearchText
Text to search for group name

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

### Thycotic.PowerShell.Groups.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Search-TssGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Search-TssGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Search-TssGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Search-TssGroup.ps1)

