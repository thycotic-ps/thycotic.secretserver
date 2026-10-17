---
title: Search-TssSdkClientAudit
parent: Sdk Client Audits
grand_parent: Commands
---
# Search-TssSdkClientAudit

## SYNOPSIS
Search SDK client audit entries

## SYNTAX

```
Search-TssSdkClientAudit [-TssSession] <Session> [-Operator <String>] [-SearchText <String>] [-UserId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the SDK client audit entries (account created, authenticated, revoked) by text or by user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSdkClientAudit -TssSession $session -SearchText 'build-agent-01'
```

Returns the SDK client audit entries matching build-agent-01

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

### -Operator
How the UserId filter applies: All, Include or Exclude

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

### -SearchText
Search text

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
Filter by user ID

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

### Thycotic.PowerShell.SdkClientAudits.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-audits/Search-TssSdkClientAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-audits/Search-TssSdkClientAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-audits/Search-TssSdkClientAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-audits/Search-TssSdkClientAudit.ps1)
