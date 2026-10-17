---
title: Get-TssGroupPlatform
parent: Groups
grand_parent: Commands
---
# Get-TssGroupPlatform

## SYNOPSIS
Get a group by its Platform or directory identifier

## SYNTAX

```
Get-TssGroupPlatform [-TssSession] <Session> -AdGuid <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a group by its AdGuid instead of its Secret Server ID.
For a Delinea Platform group this is the Platform group ID.
Returns the same object as Get-TssGroup.
Groups without an AdGuid (local groups) cannot be found this way.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupPlatform -TssSession $session -AdGuid 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Gets the group whose AdGuid is df0b8746-581f-4ac2-a9b2-5a2b7a679f3e

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

### -AdGuid
AdGuid of the group: the Platform group ID for a Platform group, or the directory object GUID

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Groups.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupPlatform](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupPlatform)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupPlatform.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupPlatform.ps1)
