---
title: Search-TssRoleAudit
parent: Roles
grand_parent: Commands
---
# Search-TssRoleAudit

## SYNOPSIS
Search role audit records

## SYNTAX

```
Search-TssRoleAudit [-TssSession] <Session> [-AuditType <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns role and role permission audit records, newest first.
Requires permission to view roles.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRoleAudit -TssSession $session
```

Returns every role audit record, newest first

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRoleAudit -TssSession $session -AuditType Permission
```

Returns only role permission audit records

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

### -AuditType
Audit records to return: All, Permission or Role.
Default All

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Roles.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleAudit.ps1)
