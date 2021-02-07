[![banner][]][Docs]

[banner]:/docs/assets/images/banner_symbol_title.png
[Docs]:https://thycotic-ps.github.io/thycotic.secretserver

# Introduction

Welcome to the Thycotic Secret Server PowerShell module. This module utilizes the REST API to allow you to manage things in Secret Server. This module is managed and maintained by Thycotic Professional Services.

The goal of the module is to be able to have a similar workflow as the UI, but also to make things easier for users to interact and write automation scripts that utilize the REST API of Secert Server.

A [quick start guide](https://github.com/thycotic-ps/thycotic.secretserver/wiki) can be found in the Wiki of this repository to provide some context around the basic use of the module.

# Changelog

A formal change log is provided in the repository ([CHANGELOG](CHANGELOG.md)), and will be included with each GitHub release.

# Installation

Recommended method will be via the module published to the PowerShell Gallery. However a few alternatives are also available:

- Download each release from GitHub [here](https://github.com/thycotic-ps/thycotic.secretserver/releases)
- Download latest release via Thycotic download link (_coming soon_)

To install via the PowerShell Gallery the latest release of [PowerShellGet module](https://docs.microsoft.com/en-us/powershell/scripting/gallery/installing-psget) will be needed. The module is in beta release at this time, so `-AllowPreRelease` will be required for both `Find-Module` and `Install-Module`. _This requires being on version 2.0.0 or greater of PowerShellGet._

# Documentation

Each function includes comment-based help, as well as `about_` topics for the classes used. A public docs web site is in progress.

# Disclaimer

The content (scripts, documentation, examples) included in this repository is not supported under any Thycotic Support program, agreement, or service. The code is provided **AS IS** without warranty of any kind. Thycotic further disclaims all implied warranties, including, without limitation, any implied warranties of merchantability or fitness for a particular purpose. The entire risk arising out of the code and content's use or performance remains with you. In no event shall Thycotic, its authors, or anyone else involved in the creation, production, or delivery of the content be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the code or content, even if Thycotic has been advised of the possibility of such damages.
