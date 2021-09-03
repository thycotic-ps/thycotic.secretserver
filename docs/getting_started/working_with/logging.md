---
title: "Logging Commands"
sort: 1
---

The below example is a script to showcase how the logging commands can be used for your scripts to easily generate a nicely formatted file.

The logging commands included in the module:

- [Start-TssLog]
- [Stop-TssLog]
- [Write-TssLog]

The first and last step of your scripts would be to use `Start-TssLog` and then `Stop-TssLog` these will add a formatted header and then a footer to the log file. The `Start` command will handle creating the log file for you if needed but does require that you give an absolute path to the file.

```powershell
# Use PSDefaultParameterValue to set the LogFile path for the script
$PSDefaultParameterValues.Remove("*:LogFilePath")
$PSDefaultParameterValues.Add('*:LogFilePath','C:\thycotic\argument_test.log')

# Write the initial header
Start-TssLog -ScriptVersion '1.0'

# Use variations of Write-TssLog to add dividers and other info
Write-TssLog -Divider
Write-TssLog -Message "Arguments:   Secret Server: $SecretServer"
Write-TssLog -Message "Arguments:   Secret: $Secret"
Write-TssLog -Divider

# Use in a try/catch block that will let you log errors
$PSDefaultParameterValues.Remove("*:TssSession")
try {
    $session = New-TssSession -SecretServer $SecretServer -Credential $credential -ErrorAction Stop
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    Write-TssLog -MessageType 'FATAL' -Message "Issue connecting to Secret Server $SecretServer - $($_.Exception)"
    return
}

try {
    $credential = Get-Secret $Secret
    Write-TssLog -Message "Credential found for login, username: $($credential.Username)"
} catch {
    Write-TssLog -MessageType 'FATAL' -Message "Unable to access Secret $Secret - $($_.Exception)"
    return
}

# use in a foreach loop to let you create sections of logging through each object
foreach ($secret in $secrets) {
    Write-TssLog -Divider
    Write-TssLog -Message "Processing Started: Secret [$($secret.SecretName)]"

    Write-TssLog -Message "Processing Completed: Secret [$($secret.SecretName)]"
    Write-TssLog -Divider
}

# Close out log with the final footer being added
Stop-TssLog
```

[Start-TssLog]:/thycotic.secretserver/commands/logging/Start-TssLog
[Stop-TssLog]:/thycotic.secretserver/commands/logging/Stop-TssLog
[Write-TssLog]:/thycotic.secretserver/commands/logging/Write-TssLog