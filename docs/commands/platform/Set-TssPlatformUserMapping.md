---
title: Set-TssPlatformUserMapping
parent: Platform
grand_parent: Commands
---
# Set-TssPlatformUserMapping

## SYNOPSIS
Map a Delinea Platform user to a Secret Server user

## SYNTAX

```
Set-TssPlatformUserMapping [-TssSession] <Session> -PlatformUserId <String> [-DirectoryServiceName <String>]
 [-ExternalUserSource <String>] -UserId <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Map a Delinea Platform user to an existing Secret Server user.
DirectoryServiceName Delinea with ExternalUserSource ThycoticOne maps through Thycotic One, EntraId maps through the Entra ID tenant of the Platform; anything else maps through the Platform login URL.
Returns Success and a Message.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$platformUser = Search-TssPlatformUser -TssSession $session -SearchText 'jdoe'
Set-TssPlatformUserMapping -TssSession $session -PlatformUserId $platformUser.Uuid -UserId 4 -ExternalUserSource Platform
```

Map the Platform user jdoe to Secret Server user 4

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

### -PlatformUserId
Platform user Id (GUID)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DirectoryServiceName
Directory service name of the Platform user, for example Delinea or EntraId

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

### -ExternalUserSource
Source of the external user: None, ThycoticOne, Azure or Platform

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

### -UserId
Secret Server user Id to map the Platform user to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Platform.UserMappingResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Set-TssPlatformUserMapping](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Set-TssPlatformUserMapping)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Set-TssPlatformUserMapping.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Set-TssPlatformUserMapping.ps1)
