---
parent: Getting Started
nav_order: 6
---

# Troubleshooting

Common errors and their fixes when using `Thycotic.SecretServer`.

## TLS 1.2 on Windows PowerShell 5.1

PowerShell Gallery and many modern web endpoints require TLS 1.2 or higher. Windows PowerShell 5.1 does not enable TLS 1.2 by default, which can produce errors like:

```text
WARNING: Unable to resolve package source 'https://www.powershellgallery.com/api/v2'.
PackageManagement\Install-Package : No match was found for the specified search criteria...
```

Set the security protocol for the current session before calling `Install-Module` or `New-TssSession`:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

PowerShell 7 negotiates the highest available TLS version automatically and does not need this step.

Reference: [PowerShell Gallery TLS support notes](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/#errors-i-might-see).

## `TaskCanceledException` or empty error from `New-TssSession`

As of v0.62.0 the module's HTTP client (RestSharp 112) no longer trusts self-signed certificates by default. Calls against a Secret Server instance with an untrusted certificate fail silently or surface as a `TaskCanceledException`.

Use `-SkipCertificateCheck` on `New-TssSession`:

```powershell
$session = New-TssSession -SecretServer https://vault.lab.local -Credential $cred -SkipCertificateCheck
```

See the [Authentication](authentication.md#self-signed-certificates--tls) page for details and the security caveat.

## "Cannot convert value" cast errors on cmdlet output

Older releases occasionally surfaced cast errors when an API response field type changed between Secret Server versions. v0.62.0 introduced `FilterTssResponse` which mitigates this for the affected endpoints.

**Fix:** upgrade to v0.62.0 or later. See [Installation](install.md).

If the error persists on the latest module against the latest Secret Server, capture a verbose log (next section) and open an issue.

## Capturing a verbose session for bug reports

When opening a GitHub issue, attach a verbose transcript so maintainers can see the full request/response flow:

```powershell
Start-Transcript -Path .\tss-debug.log
$VerbosePreference = 'Continue'

# Reproduce the failure
$session = New-TssSession -SecretServer https://vault.company.com -Credential $cred -Verbose
Get-TssSecret -TssSession $session -Id 1234 -Verbose

$VerbosePreference = 'SilentlyContinue'
Stop-Transcript
```

Redact any tokens, passwords, or secret values from `tss-debug.log` before attaching it to an issue. See the [Logging](logging.md) page for additional log locations.

## Still stuck?

- Check the [CHANGELOG](https://github.com/thycotic-ps/thycotic.secretserver/blob/dev/CHANGELOG.md) for known issues fixed in a later release.
- Search [existing issues](https://github.com/thycotic-ps/thycotic.secretserver/issues) before filing a new one.
- Open a new issue with the verbose log attached and the output of `(Get-Module Thycotic.SecretServer).Version`.
