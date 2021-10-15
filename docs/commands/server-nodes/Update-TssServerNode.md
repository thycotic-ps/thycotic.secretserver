# Update-TssServerNode

## SYNOPSIS
Update Server Node configuration

## SYNTAX

```
Update-TssServerNode [-TssSession] <Session> -NodeId <Int32[]> [-EnableBackground] [-EnableEngine]
 [-EnableSessionRecording] [-EnableInCluster] [-EnableReadonly] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update Server Node configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssServerNode -TssSession $session -NodeId 3 -EnableInCluster:$false
```

Update Server Node 3 removing it from the cluster

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssServerNode -TssSession $session -NodeId 1,2,3 -EnableReadonly
```

Update nodes 1-3 to be readonly

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssServerNode -TssSession $session -NodeId 3,4 -EnableInCluster -EnableSessionRecording
```

Update nodes 3 and 4 to be in the cluster, and enable the Session Recording worker for each

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

### -NodeId
Server Node ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnableBackground
Enable Background Worker

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

### -EnableEngine
Enable Engine Worker

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

### -EnableSessionRecording
Enable Session Recording Worker

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

### -EnableInCluster
Include in cluster

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

### -EnableReadonly
Set readonly mode

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Update-TssServerNode](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Update-TssServerNode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Update-TssServerNode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Update-TssServerNode.ps1)

