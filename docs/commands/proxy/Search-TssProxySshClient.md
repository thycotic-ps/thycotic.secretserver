---
title: Search-TssProxySshClient
parent: Proxy
grand_parent: Commands
---
# Search-TssProxySshClient

## SYNOPSIS
Search the clients that connected to the SSH terminal

## SYNTAX

```
Search-TssProxySshClient [-TssSession] <Session> [-IpAddress <String>] [-TerminalClientType <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH terminal clients Secret Server has seen: client ID, IP address, allow or block list type, and last connection date.
Use Set-TssProxySshClient to move a client to the allow list or block list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssProxySshClient -TssSession $session -TerminalClientType BlockList
```

Returns the clients on the block list

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

### -IpAddress
Return only the client with this IP address

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

### -TerminalClientType
Return only clients of this type

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Proxy.SshClient[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClient.ps1)
