---
title: Search-TssSdkClientAccount
parent: Sdk Client Accounts
grand_parent: Commands
---
# Search-TssSdkClientAccount

## SYNOPSIS
Search SDK client accounts

## SYNTAX

```
Search-TssSdkClientAccount [-TssSession] <Session> [-Operator <String>] [-SearchText <String>]
 [-UserId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Search SDK client accounts by text or by user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSdkClientAccount -TssSession $session -SearchText 'build'
```

Returns the SDK client accounts matching build

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

### Thycotic.PowerShell.SdkClientAccounts.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Search-TssSdkClientAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Search-TssSdkClientAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Search-TssSdkClientAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Search-TssSdkClientAccount.ps1)
