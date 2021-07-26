# Test-TssFolderAction

## SYNOPSIS
Test for an allowed action on a Folder

## SYNTAX

```
Test-TssFolderAction [-TssSession] <Session> -FolderId <Int32> -Action <String> [<CommonParameters>]
```

## DESCRIPTION
Test for an allowed action on a Folder

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Test-TssFolderAction -TssSession $session -FolderId 75 -Action AddSecret
```

Test for action AddSecret on Folder ID 75, returning true if exists and false if not

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

### -FolderId
Folder ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Action
Action to test for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Test-TssFolderAction](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Test-TssFolderAction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Test-TssFolderAction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Test-TssFolderAction.ps1)

