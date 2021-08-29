---
title: "Logging Commands"
sort: 1
---

The below example is a script to showcase how the logging commands can be used for your scripts to easily generate a nicely formatted file.

The logging commands included in the module:

- [Start-TssLog]
- [Stop-TssLog]
- [Write-TssLog]

# Example

```powershell
<#
.SYNOPSIS
Used to test logging and options with Thycotic.SecretServer nested module Thycotic.Logging

.NOTES
Imitates processing a list of Secrets from a source host
Utilizes SecretManagement module for storing local account used to access Secret Server

Expected arguments:
"$URL" "$SECRETNAME"
#>
[array]$params = $args
$SecretServer = $params[0]
$Secret = $params[1]

if (-not (Get-Module Microsoft.PowerShell.Management,Microsoft.PowerShellSecretManagement -List)) {
    throw "Please install and setup SecretManagement module and ensure a secret has been saved to securely store the API account used in the script process"
}
try {
    Import-Module C:\git\thycotic.secretserver\src\Thycotic.SecretServer.psd1
    Write-Output "Thycotic.SecretServer Module imported"
} catch {
    throw "Unable to load module: $_"
}

$PSDefaultParameterValues.Remove("*:LogFilePath")
$PSDefaultParameterValues.Add('*:LogFilePath','C:\thycotic\argument_test.log')

try {
    Start-TssLog -ScriptVersion '1.0'
} catch {
    throw "Unable to start log file: $_"
}

Write-TssLog -Divider
Write-TssLog -Message "Arguments:   Secret Server: $SecretServer"
Write-TssLog -Message "Arguments:   Secret: $Secret"
Write-TssLog -Divider

try {
    $credential = Get-Secret $Secret
    Write-TssLog -Message "Credential found for login, username: $($credential.Username)"
} catch {
    Write-TssLog -MessageType 'FATAL' -Message "Unable to access Secret $Secret - $($_.Exception)"
    return
}

$PSDefaultParameterValues.Remove("*:TssSession")
try {
    $session = New-TssSession -SecretServer $SecretServer -Credential $credential -ErrorAction Stop
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    Write-TssLog -MessageType 'FATAL' -Message "Issue connecting to Secret Server $SecretServer - $($_.Exception)"
    return
}
Write-TssLog -Message "Default Parameter for TssSession set"
Write-TssLog -Message "Generated ApiUrl: $($session.ApiUrl)"

Write-TssLog -Message "Getting list of Secrets that are accessible"
$secrets = Search-TssSecret -EA Stop
Write-TssLog -Message "Total count of Secrets found: $($secrets.Count)"

Write-TssLog
foreach ($secret in $secrets) {
    Write-TssLog -Divider
    Write-TssLog -Message "Processing Started: Secret [$($secret.SecretName)]"

    Write-TssLog -Message "Processing Completed: Secret [$($secret.SecretName)]"
    Write-TssLog -Divider
}

Stop-TssLog
```

[Start-TssLog]:/thycotic.secretserver/commands/logging/Start-TssLog
[Stop-TssLog]:/thycotic.secretserver/commands/logging/Stop-TssLog
[Write-TssLog]:/thycotic.secretserver/commands/logging/Write-TssLog