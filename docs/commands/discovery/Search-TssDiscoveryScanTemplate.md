---
title: Search-TssDiscoveryScanTemplate
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryScanTemplate

## SYNOPSIS
Search Discovery scan templates

## SYNTAX

```
Search-TssDiscoveryScanTemplate [-TssSession] <Session> [-DiscoveryScanTypeId <Int32>]
 [-DiscoverySourceId <Int32>] [-IncludeInput] [-OnlyIncludeBaseScanTemplates] [-SearchText <String>]
 [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Discovery scan templates (for example Active Directory Account or Computer) that shape what Discovery finds.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanTemplate -TssSession $session
```

List the active scan templates

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanTemplate -TssSession $session -DiscoveryScanTypeId 3 -OnlyIncludeBaseScanTemplates
```

List the base scan templates that find local accounts

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

### -DiscoveryScanTypeId
Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

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

### -DiscoverySourceId
Return only templates used by this discovery source

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

### -IncludeInput
Include input scan templates

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

### -OnlyIncludeBaseScanTemplates
Return only base templates (templates without a parent)

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

### -SearchText
Text to match in the template name

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

### -Status
Active, Inactive or All.
The server returns active templates when omitted

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

### Thycotic.PowerShell.Discovery.ScanTemplateSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanTemplate.ps1)
