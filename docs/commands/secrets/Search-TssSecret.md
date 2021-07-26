# Search-TssSecret

## SYNOPSIS
Search for a secret

## SYNTAX

### filter (Default)
```
Search-TssSecret [-TssSession] <Session> [-FolderId <Int32>] [-IncludeSubFolders] [-Field <String>]
 [-SearchText <String>] [-ExactMatch] [-FieldSlug <String>] [-ExtendedField <String[]>]
 [-ExtendedTypeId <Int32>] [-SecretTemplateId <Int32>] [-SiteId <Int32>] [-HeartbeatStatus <String>]
 [-IncludeInactive] [-ExcludeActive] [-RpcEnabled] [-SharedWithMe] [-PasswordTypeIds <Int32[]>]
 [-Permission <String>] [-Scope <String>] [-ExcludeDoubleLock] [-DoubleLockId <Int32>] [-SortBy <String>]
 [<CommonParameters>]
```

### folder
```
Search-TssSecret [-TssSession] <Session> [-FolderId <Int32>] [-IncludeSubFolders] [-SortBy <String>]
 [<CommonParameters>]
```

### field
```
Search-TssSecret [-TssSession] <Session> [-Field <String>] [-SearchText <String>] [-ExactMatch]
 [-FieldSlug <String>] [-ExtendedField <String[]>] [-ExtendedTypeId <Int32>] [-SortBy <String>]
 [<CommonParameters>]
```

### secret
```
Search-TssSecret [-TssSession] <Session> [-SecretTemplateId <Int32>] [-SiteId <Int32>]
 [-HeartbeatStatus <String>] [-IncludeInactive] [-ExcludeActive] [-RpcEnabled] [-SharedWithMe]
 [-PasswordTypeIds <Int32[]>] [-ExcludeDoubleLock] [-DoubleLockId <Int32>] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search for secrets using various filters provided by each parameter

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -FolderId 50
```

Return all secrets found with a folder ID of 50

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -FolderId 50 -SecretTemplateId 6001
```

Return all secrets using Secret Template 6001 that are found in FolderID 50.

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -SecretTemplateId 6047 -IncludeInactive
```

Return all secrets using Secret Template 6047 that are active **and** inactive.

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -SecretName 'Azure'
```

Return all secrets that have Azure in the name of the Secret (wildcard search)

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -SecretName 'Azure Test Account' -ExactMatch
```

Return all secret(s) that have the exact name "Azure Test Account"

### EXAMPLE 6
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -Field username -SearchText 'root'
```

Return all secret(s) that have the username "root"

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
Return only secrets within a certain folder

```yaml
Type: Int32
Parameter Sets: filter, folder
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSubFolders
Include secrets in subfolders of the specified FolderId

```yaml
Type: SwitchParameter
Parameter Sets: filter, folder
Aliases: IncludeSubFolder

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Field
Field to filter on

```yaml
Type: String
Parameter Sets: filter, field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text of the field to filter on

```yaml
Type: String
Parameter Sets: filter, field
Aliases: SecretName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExactMatch
Match the exact text of the SearchText

```yaml
Type: SwitchParameter
Parameter Sets: filter, field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldSlug
Field-slug to search
This overrides the Field filter

```yaml
Type: String
Parameter Sets: filter, field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtendedField
Secret Template fields to return
Only exposed fields can be returned

```yaml
Type: String[]
Parameter Sets: filter, field
Aliases: ExtendedFields

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtendedTypeId
Return only secrets matching a certain extended type

```yaml
Type: Int32
Parameter Sets: filter, field
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTemplateId
Return only secrets matching a certain template

```yaml
Type: Int32
Parameter Sets: filter, secret
Aliases: TemplateId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Return only secrets within a certain site

```yaml
Type: Int32
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatStatus
Return only secrets with a certain heartbeat status

```yaml
Type: String
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive/disabled secrets

```yaml
Type: SwitchParameter
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeActive
Exclude active secrets

```yaml
Type: SwitchParameter
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpcEnabled
Secrets where template has RPC Enabled

```yaml
Type: SwitchParameter
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SharedWithMe
Secrets where you are not the owner and secret is explicitly shared with your user

```yaml
Type: SwitchParameter
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordTypeIds
Secrets matching certain password types

```yaml
Type: Int32[]
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Permission
Filter based on permission (List, View, Edit or Owner)

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Filter All Secrets, Recent or Favorites

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeDoubleLock
Exclude DoubleLocks from search results

```yaml
Type: SwitchParameter
Parameter Sets: filter, secret
Aliases: ExcludeDoubleLocks

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoubleLockId
Include only secrets with a specific DoubleLock ID assigned

```yaml
Type: Int32
Parameter Sets: filter, secret
Aliases:

Required: False
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Secrets.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecret.ps1)

