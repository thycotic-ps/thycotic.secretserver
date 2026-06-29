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

## `Cannot convert "System.Object[]"` from `Search-TssSecret` after upgrading to 0.62.1

`Search-TssSecret` now always returns `Thycotic.PowerShell.Secrets.Summary[]` (a typed array), including the empty case. In v0.62.0 the cmdlet auto-unwrapped a single result, so a singular receiver happened to work when exactly one secret matched:

```powershell
# Worked in v0.62.0 only when one secret matched, fails for 0 or many:
[Thycotic.PowerShell.Secrets.Summary] $secret = Search-TssSecret -TssSession $session -SecretName 'unique'
```

After 0.62.1 this errors regardless of result count because PowerShell cannot fit an array into a single-object receiver. Pick whichever migration fits your script:

```powershell
# Option A - typed array receiver, then index. Recommended.
[Thycotic.PowerShell.Secrets.Summary[]] $secrets = Search-TssSecret -TssSession $session -SecretName 'unique'
$secret = $secrets[0]

# Option B - index inline if you only ever expect one result.
$secret = (Search-TssSecret -TssSession $session -SecretName 'unique')[0]

# Option C - drop the type annotation and let PowerShell unwrap on assignment.
$secret = Search-TssSecret -TssSession $session -SecretName 'unique' | Select-Object -First 1
```

The always-array contract makes the return shape independent of result count. `$secrets.Count` and `$secrets[0]` work the same way for 0, 1, or N results, which removes a class of scripts that silently misbehave when a search unexpectedly returns more or fewer matches than the author expected.

### Related: `[OutputType()]` declarations corrected across other collection cmdlets

The 0.62.1 release also corrects `[OutputType()]` metadata on roughly 70 collection-returning cmdlets (for example `Get-TssFolder`, `Search-TssGroup`, `Search-TssUser`, `Get-TssSecretAudit`). They previously declared a singular type but cast to `[Type[]]` internally, so `Get-Help` and IntelliSense advertised the wrong shape. Only the metadata changed - no runtime behavior change - so existing scripts that consumed these cmdlets continue to work. Internal tests against the lab confirmed no regression for these cmdlets.

### If you hit a problem with 0.62.1 that this page does not cover

If a script broke after upgrading from 0.62.0 and the migration options above do not explain it, treat it as a regression and report it.

**Open a new issue at https://github.com/thycotic-ps/thycotic.secretserver/issues with all of the following:**

- Exact error message and stack trace, copied verbatim.
- The cmdlet invocation that triggered it, minimised to the smallest reproducer you can produce.
- Module version: output of `(Get-Module Thycotic.SecretServer).Version`.
- PowerShell host and version: `$PSVersionTable.PSVersion` and `$PSVersionTable.PSEdition`.
- Secret Server edition and version (Platinum/Premium/Cloud/etc and the build number from the SS UI footer).
- A verbose log of the failing call: `New-TssSession ... -Verbose 4>verbose.log` or `Search-TssSecret ... -Verbose 4>verbose.log` (redact tokens before attaching).
- Whether the same call worked on 0.62.0 against the same Secret Server.

**While you wait, roll back to 0.62.0:**

```powershell
Remove-Module Thycotic.SecretServer -Force -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri 'https://github.com/thycotic-ps/thycotic.secretserver/releases/download/v0.62.0/Thycotic.SecretServer.zip' -OutFile '.\Thycotic.SecretServer-0.62.0.zip'
Expand-Archive -Path '.\Thycotic.SecretServer-0.62.0.zip' -DestinationPath '.\Thycotic.SecretServer-0.62.0' -Force
Import-Module '.\Thycotic.SecretServer-0.62.0\Thycotic.SecretServer\Thycotic.SecretServer.psd1' -Force
(Get-Module Thycotic.SecretServer).Version  # should report 0.62.0
```

The 0.62.0 zip is the last known-good build that does not change `Search-TssSecret`'s return shape. PowerShell Gallery is not an option for 0.62.x rollback - see [issue #450](https://github.com/thycotic-ps/thycotic.secretserver/issues/450).

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
