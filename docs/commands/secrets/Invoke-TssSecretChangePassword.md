---
title: Invoke-TssSecretChangePassword
parent: Secrets
grand_parent: Commands
---
# Invoke-TssSecretChangePassword

## SYNOPSIS
Queue a remote password change on a secret

## SYNTAX

```
Invoke-TssSecretChangePassword [-TssSession] <Session> -Id <Int32[]> [-NewPassword <SecureString>]
 [-Comment <String>] [-TicketNumber <String>] [-TicketSystemId <Int32>] [-DoubleLockPassword <SecureString>]
 [-ForceCheckIn] [-IncludeInactive] [-NoAutoCheckout] [-IsForceCheckoutRequestApproval]
 [-PreventFurtherRetriesAfterMaxAttempts] [-GenerateSshKeys] [-GeneratePassphrase] [-PrivateKey <String>]
 [-Passphrase <SecureString>] [-AutoCheckIn] [-AutoCheckout] [-AutoComment <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Queue a remote password change (RPC) on a secret through the public REST route.
Without -NewPassword (or the SSH key parameters) Secret Server generates the next value from the template's password requirements.
The change runs on the next Remote Password Changing cycle; follow it with Get-TssSecretPasswordStatus.
Remote Password Changing must be enabled and the secret's template must have a password changer; the server rejects the request otherwise.
Start-TssSecretChangePassword uses the internal change-password-now route instead; this command also takes a comment, a ticket number, a double lock password and SSH key options.
The request body is never written to Verbose or WhatIf output.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssSecretChangePassword -TssSession $session -Id 46 -Comment 'Quarterly rotation'
```

Queue a password change on secret 46 with a server-generated password

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$next = Read-Host -AsSecureString -Prompt 'Next password'
Invoke-TssSecretChangePassword -TssSession $session -Id 46 -NewPassword $next
Get-TssSecretPasswordStatus -TssSession $session -Id 46
```

Queue a change to a caller-supplied password, then read the change status

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssSecretChangePassword -TssSession $session -Id 52 -GenerateSshKeys -GeneratePassphrase
```

Queue a rotation of the private key and passphrase on SSH key secret 52

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

### -Id
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewPassword
Next password; omit to let Secret Server generate one

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

### -Comment
Comment for the secret audit, required when the secret requires a comment

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

### -TicketNumber
Ticket number, required when the secret requires a ticket number

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

### -TicketSystemId
Ticket system ID used to validate -TicketNumber

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

### -DoubleLockPassword
Double lock password, required when the secret is double locked

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

### -ForceCheckIn
Check the secret in first when another user has it checked out

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

### -IncludeInactive
Allow the change on an inactive secret

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

### -NoAutoCheckout
Do not check the secret out automatically

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

### -IsForceCheckoutRequestApproval
Request approval for a forced check-out

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

### -PreventFurtherRetriesAfterMaxAttempts
Stop retrying the change once the maximum number of attempts is reached

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

### -GenerateSshKeys
SSH key secrets: generate the next private key

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

### -GeneratePassphrase
SSH key secrets: generate the next passphrase

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

### -PrivateKey
SSH key secrets: next private key text

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

### -Passphrase
SSH key secrets: next passphrase

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

### -AutoCheckIn
Check the secret in automatically after the request

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

### -AutoCheckout
Check the secret out automatically for the request

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

### -AutoComment
Comment to use for the automatic check-out

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.Secrets.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretChangePassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretChangePassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretChangePassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretChangePassword.ps1)
