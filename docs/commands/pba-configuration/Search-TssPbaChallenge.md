---
title: Search-TssPbaChallenge
parent: Pba Configuration
grand_parent: Commands
---
# Search-TssPbaChallenge

## SYNOPSIS
Search Privilege Behavior Analytics (PBA) challenges

## SYNTAX

```
Search-TssPbaChallenge [-TssSession] <Session> [-Completed] [-DayRange <Int32>] [-SearchText <String>]
 [-ChallengeType <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns the PBA challenges raised against users, with who cleared each one and when.
An empty result is normal when PBA has raised no challenges.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPbaChallenge -TssSession $session
```

Returns the PBA challenges from the last day

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPbaChallenge -TssSession $session -SearchText jsmith -DayRange 7
```

Returns challenges from the last 7 days that match jsmith

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

### -Completed
Return only completed (cleared) challenges

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

### -DayRange
Number of days back to search.
Defaults to 1, the last day

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to match against the challenge records, such as a user name

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

### -ChallengeType
Challenge type id to filter by

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PbaConfiguration.Challenge[]
## NOTES
Requires TssSession object returned by New-TssSession

Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Search-TssPbaChallenge](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Search-TssPbaChallenge)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Search-TssPbaChallenge.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Search-TssPbaChallenge.ps1)
