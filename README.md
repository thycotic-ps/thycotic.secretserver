<img src="https://user-images.githubusercontent.com/11204251/102900538-0b165a80-4432-11eb-9164-2996d0222a88.png" width="30" height="30">
A contribution guide is pending, due to this Pull Requests are not being accepted at this time.
<img src="https://user-images.githubusercontent.com/11204251/102900538-0b165a80-4432-11eb-9164-2996d0222a88.png" width="30" height="30">

# Introduction

Welcome to the Thycotic Secret Server PowerShell module. This module utilizes the REST API to allow you to manage things in Secret Server. This module is managed and maintained by Professional Services.

The goal of the module is to be able to have a similar workflow as the UI, but also to make things easier for users for interactive and writing automation scripts. In some cases, an endpoint's raw output is manipulated to be more readable and matching the output of the product's UI. Where applicable, each command will include a `-Raw` parameter for users to access that raw output of an endpoint utilized.

> There will be functions that will utilize multiple endpoints to accomplish this and, therefore, will not have the `-Raw` parameter.

# Installation

Installing the module can be done via the PowerShell Gallery.

It is recommended to update to the latest release of [PowerShellGet module](https://docs.microsoft.com/en-us/powershell/scripting/gallery/installing-psget). The module is in beta release at this time, so `-AllowPreRelease` will be required for both `Find-Module` and `Install-Module`. _This requires being on version 2.0.0 or greater of PowerShellGet._

## Limitations

The limitations in the product's REST API will also limit the module. Discovery of these limitations is being provided to Product Management by the maintainers of this module. As those are addressed or endpoints enhanced, the module will be updated accordingly.

# Bugs and Feature Request

**This repository is not the place to submit feature requests or bugs around the Secret Server's REST API.**

Issues and bug reports are welcomed.

# Documentation

Each function includes comment-based help. An online source for this documentation is still TBD.

# Testing

At this time, the PowerShell module Pester is utilized for writing both unit and integration tests.
