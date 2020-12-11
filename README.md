# Introduction

Welcome to the Thycotic Secret Server PowerShell module. This module utilizes the REST API to allow you to manage things in Secret Server.

This module is managed and maintained by Professional Services.

# Installation

Primary means to install the module is via the PowerShell Gallery. The module is released at this time as a pre-release. So you **will need** [PowerShellGet module](https://docs.microsoft.com/en-us/powershell/scripting/gallery/installing-psget) 2.2.4 or higher.

## Limitations

The limitations of the module is at the mercy of the REST API endpoints (for the most part). As the API for Secret Server expands the module will expand as well.

The goal of the module is to be able to have a similar workflow that the UI. In some cases raw output of an endpoint is manipulated to match with similar output or properties you may view within the UI as well.This also includes having multiple API calls included within given functions to help lessen the burden on the user wanting to automate various task against Secret Server.

# Documentation

Each function will include comment-based help.

Online documentation: TBD

# Testing

At this time basic testing is being done utilizing Pester and those tests can be found in the tests directory of this repository.
