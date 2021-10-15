# Search-TssServerNode

## SYNOPSIS
Return list of Server Nodes for Secret Server

## SYNTAX

```
Search-TssServerNode [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Return list of Server Nodes for Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssServerNode -TssSession $session -
```

Returns list of all Server Nodes

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ServerNodes.List
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Search-TssServerNode](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Search-TssServerNode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Search-TssServerNode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Search-TssServerNode.ps1)

