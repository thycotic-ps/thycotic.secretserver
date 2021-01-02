<img src="https://user-images.githubusercontent.com/11204251/102900538-0b165a80-4432-11eb-9164-2996d0222a88.png" width="30" height="30">
A contribution guide is pending, due to this Pull Requests are not being accepted at this time.

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

## Limitations

The limitations in the product's REST API will also limit the module. Discovery of these limitations is being provided to Product Management by the maintainers of this module. As those are addressed or endpoints enhanced, the module will be updated accordingly.

# Bugs and Feature Request

**This repository is not the place to submit feature requests or bugs around the Secret Server's REST API.**

Issues and bug reports are welcomed.

# Documentation

Each function includes comment-based help. An online source for this documentation is still TBD.

# Testing

At this time, the PowerShell module Pester is utilized for writing both unit and integration tests.
