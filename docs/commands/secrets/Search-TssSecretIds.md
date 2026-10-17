---
title: Search-TssSecretIds
parent: Secrets
grand_parent: Commands
---
# Search-TssSecretIds

## SYNOPSIS
Get the IDs of secrets matching a search filter

## SYNTAX

```
Search-TssSecretIds [-TssSession] <Session> [-SearchText <String>] [-FolderId <Int32>] [-IncludeSubFolders]
 [-Field <String>] [-FieldSlug <String>] [-ExactMatch] [-SecretTemplateId <Int32[]>] [-SiteId <Int32>]
 [-HeartbeatStatus <SecretHeartbeatStatus>] [-IncludeInactive] [-IncludeRestricted] [-RpcEnabled]
 [-SharedWithMe] [-PasswordTypeIds <Int32[]>] [-DoubleLockId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the ID of every secret the current user can see that matches the filter.
Lighter than Search-TssSecret when only IDs are needed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretIds -TssSession $session -FolderId 12 -IncludeSubFolders
```

Returns the IDs of the secrets in folder 12 and its subfolders

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretIds -TssSession $session -SearchText 'sql' | ForEach-Object { Get-TssSecret -TssSession $session -Id $_ }
```

Gets each secret whose name or fields match sql

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

### -SearchText
Text to match against secret names and field values

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

### -FolderId
Only secrets in this folder

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

### -IncludeSubFolders
Include secrets in subfolders of FolderId

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
Field name to search with SearchText

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

### -FieldSlug
Field slug to search with SearchText

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

### -ExactMatch
Match SearchText exactly

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

### -SecretTemplateId
Only secrets of these secret templates

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Only secrets assigned to this site

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

### -HeartbeatStatus
Only secrets with this heartbeat status

```yaml
Type: SecretHeartbeatStatus
Parameter Sets: (All)
Aliases:
Accepted values: Failed, Success, Pending, Disabled, UnableToConnect, UnknownError, IncompatibleHost, AccountLockedOut, DnsMismatch, UnableToValidateServerPublicKey, Processing, ArgumentError, AccessDenied

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive secrets

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

### -IncludeRestricted
Include restricted secrets (checkout, approval, comment or double lock required)

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

### -RpcEnabled
Only secrets whose template has password changing enabled

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

### -SharedWithMe
Only secrets explicitly shared with the current user

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

### -PasswordTypeIds
Only secrets with these password types

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoubleLockId
Only secrets with this double lock

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Int32[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretIds](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretIds)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretIds.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretIds.ps1)
