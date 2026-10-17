---
title: Search-TssRestDocumentationService
parent: Rest Documentation
grand_parent: Commands
---
# Search-TssRestDocumentationService

## SYNOPSIS
List the REST API services documented by Secret Server

## SYNTAX

```
Search-TssRestDocumentationService [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the REST API service groups (name, display name and description) listed in the REST API documentation of the instance.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRestDocumentationService -TssSession $session
```

Returns the documented REST API services

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.RestDocumentation.Service[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/rest-documentation/Search-TssRestDocumentationService](https://thycotic-ps.github.io/thycotic.secretserver/commands/rest-documentation/Search-TssRestDocumentationService)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rest-documentation/Search-TssRestDocumentationService.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rest-documentation/Search-TssRestDocumentationService.ps1)
