---
sort: 4
---

# Working with Users

These are example scripts that utilize the Thycotic.SecretServer module for various tasks managing local users with Secret Server.

## Examples

### Create Local Users via CSV

1. Add Get-TssConfigLocalUserPassword in order to pull the password requires
1. Add Get-TssUserStub to get an initial user object
1. Based on config data generate random password to meet length and requirements of complexity
1. Add New-TssUser that will accept the stub object and generated password value