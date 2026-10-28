---
title: Search-TssRecordedSession
parent: Recorded Sessions
grand_parent: Commands
---
# Search-TssRecordedSession

## SYNOPSIS
Search recorded sessions

## SYNTAX

```
Search-TssRecordedSession [-TssSession] <Session> [-Active] [-DateRange <Int32>] [-EndDate <DateTime>]
 [-EndTime <String>] [-ExcludedApplications <String[]>] [-FolderId <Int32>] [-GroupIds <Int32[]>] [-HasError]
 [-IncludeNonSecretServerSessions] [-IncludeOnlyLaunchedSuccessfully] [-IncludeRestricted] [-IncludeSubFolders]
 [-LauncherTypeId <Int32>] [-SearchText <String>] [-SearchTypes <String[]>] [-SecretIds <Int32[]>]
 [-SiteId <Int32>] [-StartDate <DateTime>] [-StartTime <String>] [-UserIds <Int32[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the recorded sessions shown on the Session Monitoring page, filtered by text, status, date, folder, secret, user, group, site or launcher type.
Secret Server needs at least one search type; when SearchTypes is not given, SecretItems, Username, Hostname and Domain are searched.
DateRange wins over StartDate and EndDate.
StartDate and EndDate apply only when both are given; StartTime and EndTime apply only when both dates and both times are given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -DateRange 7
```

Get the recorded sessions of the last 7 days

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -SearchText web01 -SearchTypes Hostname -Active
```

Get the active sessions on hosts matching web01

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -SecretIds 42 -StartDate 2026-01-01 -EndDate 2026-01-31
```

Get the sessions of secret 42 in January 2026

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

### -Active
Return only active sessions; -Active:$false returns only ended sessions

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

### -DateRange
Return sessions from the last number of days

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

### -EndDate
Return sessions up to this date (used only together with StartDate)

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndTime
Time of day on EndDate, for example 17:30 (used only together with StartTime)

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

### -ExcludedApplications
Application names to leave out of the results

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Return sessions of secrets in this folder

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

### -GroupIds
Return sessions of the users in these groups

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

### -HasError
Return only sessions with a processing error; -HasError:$false returns only sessions without one

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

### -IncludeNonSecretServerSessions
Include sessions that were not launched from a secret

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

### -IncludeOnlyLaunchedSuccessfully
Return only sessions that launched successfully

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
Include sessions of restricted secrets

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

### -IncludeSubFolders
Include sessions of secrets in subfolders of FolderId

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

### -LauncherTypeId
Return sessions of this launcher type

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

### -SearchText
Text to search for across the search types

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

### -SearchTypes
Sources to search across: SecretName, SecretItems, Username, Hostname, Domain, RdpKeystroke, RdpApplication, ProxyClient (default SecretItems, Username, Hostname, Domain)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @('SecretItems', 'Username', 'Hostname', 'Domain')
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretIds
Return sessions of these secrets

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
Return sessions run through this site

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

### -StartDate
Return sessions from this date (used only together with EndDate)

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTime
Time of day on StartDate, for example 08:00 (used only together with EndTime)

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

### -UserIds
Return sessions of these users

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.RecordedSessions.RecordedSessionItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Search-TssRecordedSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Search-TssRecordedSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Search-TssRecordedSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Search-TssRecordedSession.ps1)
