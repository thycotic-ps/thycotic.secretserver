---
title: Test-TssCustomCommand
parent: Remote Password Changing
grand_parent: Commands
---
# Test-TssCustomCommand

## SYNOPSIS
Test the custom commands of a password type against a target

## SYNTAX

```
Test-TssCustomCommand [-TssSession] <Session> -PasswordTypeId <Int32> -CommandTypeCode <Int32> -SiteId <Int32>
 -Credential <PSCredential> [-Passphrase <SecureString>] [-KeyInput <String>]
 [-PasswordTypeWebScriptId <Int32>] [-Field <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
Runs the custom commands of one command type of a password type against a target system, through a site, and returns the console output, the error message and whether the run succeeded.
The commands really run on the target with the account in -Credential.
Target details go in -Field, keyed by the token name the commands use without the $ (for example Machine).
The request body is not written to Verbose output because it carries the account password, passphrase and key.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$cred = Get-Credential
Test-TssCustomCommand -TssSession $session -PasswordTypeId 9 -CommandTypeCode 1 -SiteId 1 -Credential $cred -Field @{ Machine = 'unix01.example.com' }
```

Run the type 1 commands of password type 9 against unix01 through site 1 and show the result

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

### -PasswordTypeId
ID of the password type whose commands are tested

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CommandTypeCode
Command type code of the commands to run: 1 password change, 2 verify password (heartbeat), 3 password change with other credentials

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

### -SiteId
ID of the site (distributed engine site) that runs the commands

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

### -Credential
Account the commands run as

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passphrase
Passphrase of the private key in -KeyInput.
An empty passphrase is sent when omitted (the server requires the field for SSH password types)

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyInput
Private key text for key based logins, for example the output of Get-Content -Raw on a key file

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

### -PasswordTypeWebScriptId
Web script ID, for web based password types

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

### -Field
Token values as a hashtable of token name (without the $) and value, for example @{ Machine = 'unix01.example.com' }

```yaml
Type: Hashtable
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

### Thycotic.PowerShell.Rpc.CustomCommandTestResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Test-TssCustomCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Test-TssCustomCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Test-TssCustomCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Test-TssCustomCommand.ps1)
