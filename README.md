[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/thycotic-ps/thycotic.secretserver)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/thycotic-ps/thycotic.secretserver?style=flat-square)
![GitHub Last Commit](https://img.shields.io/github/last-commit/thycotic-ps/thycotic.secretserver?style=flat-square)
![GitHub issues by-label](https://img.shields.io/github/issues/thycotic-ps/thycotic.secretserver/bugs?style=flat-square)

<h1 align="center">Thycotic.SecretServer PowerShell Module</h1>
<p></p>

## Purpose

This module provides a secure method that Secret Server Administrators and Users can use for managing and automating their environment. Scripts and automated processing that requires a privileged (or non-privileged) account have to be stored somewhere. Why store them in plaintext within a script or in an XML file that only uses DPAPI encryption (`SecureString > Export-Clixml`)?

Secret Server provides a management tool for those privileged accounts. Thycotic.SecretServer module allows you to access those accounts securely and utilize them in your scripts and automation in a secure manner.

## Classes

The module utilizes C# based classes to provide a unique object and type with each endpoint. In addition, certain classes may include Methods that provide "shortcuts" for performing specific actions in PowerShell or manipulating the object output by a function.

Documentation for the classes can be found on the documentation site here: [about topics](https://thycotic-ps.github.io/thycotic.secretserver/about_topics/)

### Library Build

The source code for the library is found in the `src\Thycotic.SecretServer` folder. This project utilizes [InvokeBuild](https://powershellgallery.com/packages/InvokeBuild) to build the library.

If you would like to locally debug the project for contributing or your purpose, clone the repository and then run the following command:

> You will need PowerShell 7 installed for this process!

```powershell
# Install the InvokeBuild module if not already
Install-Module InvokeBuild

# build the library
Invoke-Build -File .\build.ps1 -Configuration Debug
```

## Maintainers

This module is managed and maintained by Thycotic Professional Services.

## Support

See the Disclaimer at the bottom of this page for other legal jargon. This module is an open-source project. Maintenance and support are provided using the standard GitHub measures via [GitHub Issues](https://github.com/thycotic-ps/thycotic.secretserver/issues/new) or [GitHub Discussion](https://github.com/thycotic-ps/thycotic.secretserver/discussions/new).

If a customer desires more in-depth assistance implementing the module in their environment, please reach out to your Thycotic Account Rep to engage [Thycotic Professional Services](https://thycotic.com/products/professional-services-training/).

## Install Options

This project strives to cover all types of environments. We understand that some do not allow pulling PowerShell modules from every resource. The following sources are available for downloading each release of the module:

- [PowerShell Gallery](https://www.powershellgallery.com/packages/Thycotic.SecretServer/) (recommended)
- [GitHub Release](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest) (latest)
- [Direct Download](https://thyproservices.z20.web.core.windows.net/Thycotic.SecretServer.zip)

Documentation on installing the module can be found on the documentation site [here](https://thycotic-ps.github.io/thycotic.secretserver/docs/install)

## Changelog

A formal changelog is provided in the repository ([CHANGELOG](CHANGELOG.md)) and with each GitHub release.

## Documentation

All documentation for the module is hosted in this project and utilizes GitHub Pages: [https://thycotic-ps.github.io/thycotic.secretserver](https://thycotic-ps.github.io/thycotic.secretserver)

You will also find in-module help for functions via comment-based help that can be accessed using `Get-Help`.

# Show your support

Give a ⭐️ if this project helped you!

# Disclaimer

The content (scripts, documentation, examples) included in this repository is not supported under any Thycotic Support program, agreement, or service. The code is provided **AS IS** without warranty of any kind. Thycotic further disclaims all implied warranties, including, without limitation, any implied warranties of merchantability or fitness for a particular purpose. The entire risk arising out of the code and content's use or performance remains with you. In no event shall Thycotic, its authors, or anyone else involved in the creation, production, or delivery of the content be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the code or content, even if Thycotic has been advised of the possibility of such damages.
