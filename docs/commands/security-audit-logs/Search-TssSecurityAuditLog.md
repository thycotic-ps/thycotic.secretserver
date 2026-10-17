---
title: Search-TssSecurityAuditLog
parent: Security Audit Logs
grand_parent: Commands
---
# Search-TssSecurityAuditLog

## SYNOPSIS
Search the security audit log

## SYNTAX

```
Search-TssSecurityAuditLog [-TssSession] <Session> [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Searches the security audit log: security relevant events such as changes to users, roles, permissions and configuration, with who made them, from which IP address and machine, and when.
Returns the entries visible to the caller.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecurityAuditLog -TssSession $session
```

Get the security audit log entries

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecurityAuditLog -TssSession $session -SearchText 'role'
```

Get the security audit log entries that mention role

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
Return only the entries whose text matches

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

### Thycotic.PowerShell.SecurityAuditLogs.SecurityAuditLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/security-audit-logs/Search-TssSecurityAuditLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/security-audit-logs/Search-TssSecurityAuditLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/security-audit-logs/Search-TssSecurityAuditLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/security-audit-logs/Search-TssSecurityAuditLog.ps1)
