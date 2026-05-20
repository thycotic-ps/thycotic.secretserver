---
parent: Getting Started
nav_order: 1
---

# Installation

{% capture notice-text %}
- PowerShell 7+ (required for new installs). Windows PowerShell 5.1 is still supported for users running older module releases — see the [Troubleshooting](troubleshooting.md) page for the TLS 1.2 setup required on 5.1.
- Thycotic Secret Server Web Service enabled
- A user to authenticate with appropriate permissions to access desired objects.
{% endcapture %}

<div class="notice--info">
  <h2>Prerequisites:</h2>
  {{ notice-text | markdownify }}
</div>

`Thycotic.SecretServer` is available to download from the following locations:

- [GitHub Release](https://github.com/thycotic-ps/thycotic.secretserver/releases/) (current: v0.62.0)
- [CDN Download](https://downloads.marketplace.delinea.com/integrations/Downloads/PowershellModule/0.62.0/Thycotic.SecretServer.zip)
- [Direct Download](https://delineamarketplace01qa.blob.core.windows.net/integrations/Downloads/PowershellModule/0.62.0/Thycotic.SecretServer.zip)
- [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/) — **not updated past 0.60.4** (tracking: [#450](https://github.com/thycotic-ps/thycotic.secretserver/issues/450))

Choose one of the following methods to obtain & install the module:

## Option 1: Manual Install

You can manually copy the module to a desired PowerShell Modules path, `PSModulePath`.

The paths included in `PSModulePath` can be found using the following command:

```powershell
$env:PSModulePath.split(';')
```

Place the `Thycotic.SecretServer` module folder in one of the listed locations.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

There are multiple options for downloading the module files:


### GitHub Release

1. [Download the latest release from GitHub](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest)
2. Unblock & Extract the `Thycotic.SecretServer.zip`
3. Copy the `Thycotic.SecretServer` folder to your "Powershell Modules" directory of choice.

### CDN Download

1. [Download the latest release file](https://downloads.marketplace.delinea.com/integrations/Downloads/PowershellModule/0.62.0/Thycotic.SecretServer.zip)
2. Unblock & Extract the archive
3. Copy the `Thycotic.SecretServer` folder to your "Powershell Modules" directory of choice.

### Direct Download

1. [Download the latest release file](https://delineamarketplace01qa.blob.core.windows.net/integrations/Downloads/PowershellModule/0.62.0/Thycotic.SecretServer.zip)
2. Unblock & Extract the archive
3. Copy the `Thycotic.SecretServer` folder to your "Powershell Modules" directory of choice.

### Integrity verification

The published SHA256 hash for each release is at [thycotic.secretserver_hash.txt](https://thyproservices.z20.web.core.windows.net/Thycotic.SecretServer_hash.txt). Verify the downloaded zip before extracting:

```powershell
Get-FileHash -Algorithm SHA256 .\Thycotic.SecretServer.zip
```

Compare the output to the hash file above.

## Verification

Validate Install:

```powershell
Get-Module -ListAvailable Thycotic.SecretServer

# or

Get-InstalledModule Thycotic.SecretServer
```

Confirm the installed version matches the release you downloaded:

```powershell
(Get-Module -ListAvailable Thycotic.SecretServer).Version
```

Import the module:

```powershell
Import-Module Thycotic.SecretServer
```

List Module Commands:

```powershell
Get-Command -Module Thycotic.SecretServer
```

Get detailed information on specific commands:

```powershell
Get-Help Get-TssSecret -Full
```
## Option 2: Install from PowerShell Gallery

> **Warning** **PowerShell Gallery is not updated past 0.60.4.** Installing from PSGallery will give you an outdated module missing the fixes and features in 0.61.x and 0.62.0. Use Option 1 (Manual Install) to get the current release. Tracking: [#450](https://github.com/thycotic-ps/thycotic.secretserver/issues/450).

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name Thycotic.SecretServer -Scope CurrentUser
```

> **Warning** **PowerShell 7+** must be used to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/).

> **Warning** **Windows PowerShell 5.1** TLS error: PowerShell Gallery only supports TLS 1.2 and above, errors noted [here](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/#errors-i-might-see) may be observed. You will need to start a new PowerShell session and set TLS to 1.2: `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`. PowerShell 7 negotiates TLS automatically and does not need this step. See [Troubleshooting](troubleshooting.md) for more.