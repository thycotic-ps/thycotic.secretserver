---
sort: 1
---

# Installation

{% capture notice-text %}
- Windows Powershell v5.1, or PowerShell 7+
- Thycotic Secret Server Web Service enabled
- A user to authenticate with appropriate permissions to access desired objects.
{% endcapture %}

<div class="notice--info">
  <h2>Prerequisites:</h2>
  {{ notice-text | markdownify }}
</div>

`Thycotic.SecretServer` is available to download from the following locations:

- [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/)
- [GitHub Releases](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest)
- [Direct download](https://thyproservices.z20.web.core.windows.net/Thycotic.SecretServer.zip)

Choose one of the following methods to obtain & install the module:

## Option 1: Install from PowerShell Gallery

PowerShell Gallery is the preferred method for installing the module.

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name Thycotic.SecretServer -Scope CurrentUser
```

> **Warning** **Windows PowerShell 5.1 or PowerShell 7+** must be used to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/).

> **Warning** **Windows PowerShell 5.1** TLS error: PowerShell Gallery only supports TLS 1.2 and above, errors noted [here](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/#errors-i-might-see) may be observed. You will need to start a new PowerShell session and set TLS to 1.2: `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`

## Option 2: Manual Install

You can manually copy the module to a desired PowerShell Modules path, `PSModulePath`.

The paths included in `PSModulePath` can be found using the following command:

```powershell
$env:PSModulePath.split(';')
```

Place the `Thycotic.SecretServer` module folder in one of the listed locations.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

There are multiple options for downloading the module files:

### PowerShell Gallery

- Download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/) by running:

```powershell
Save-Module -Name Thycotic.SecretServer -Path C:\temp -AllowPrerelease
```

Copy the `Thycotic.SecretServer` directory to the `PSModules` path of choice.

You can also use the module from the saved path by providing the absolute path to the PSD1 file:

```powershell
Import-Module c:\temp\Thycotic.SecretServer\<version>\Thycotic.SecretServer.psd1
```

### GitHub Release

1. [Download the latest release from GitHub](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest)
2. Unblock & Extract the `Thycotic.SecretServer.zip`
3. Copy the `Thycotic.SecretServer` folder to your "Powershell Modules" directory of choice.

### Direct File Download

1. [Download the latest release file](https://thyproservices.z20.web.core.windows.net/Thycotic.SecretServer.zip)
2. Unblock & Extract the archive
3. Copy the `Thycotic.SecretServer` folder to your "Powershell Modules" directory of choice.

> **Warning** **Thycotic.SecretServer.zip SHA256:** [thycotic.secretserver_hash.txt](https://thyproservices.z20.web.core.windows.net/Thycotic.SecretServer_hash.txt)

## Verification

Validate Install:

```powershell
Get-Module -ListAvailable Thycotic.SecretServer

# or

Get-InstalledModule Thycotic.SecretServer
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
