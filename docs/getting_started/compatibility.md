---
sort: 3
---

# Compatibility

Secret Server REST API was first released with version 9.0. The API has grown since then and continues to grow as the product evolves. The module is tested on the latest Secret Server release available. This page aims to provide a list of endpoints that are only available in specific build versions of Secret Server.

The starting version for maintaining this content will be Secret Server 10.9.
{: .notice--warning}

Each function included below will have a version check on Secret Server before the endpoint is called.
{: .notice--info}

## Function List

The Secret Server version listed is the minimum required to use the function.
{: .notice--info}

**Function Name**                   | **Secret Server Version**     |
----------------------------------- | ----------------------------- |
[Get-TssConfiguration]              | 10.9.000032
[Search-TssDistributedEngineSite]   | 10.9.000032
[Get-TssSecretAudit]                | 10.9.000032
[Get-TssSecretState]                | 10.9.000032
[Get-TssUserRoleAssigned]           | 10.9.000032

[Get-TssSecretAudit]:/thycotic.secretserver/commands/secrets/Get-TssSecretAudit
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned
[Get-TssSecretState]:/thycotic.secretserver/commands/secrets/Get-TssSecretState
[Get-TssConfiguration]:/thycotic.secretserver/commands/configurations/Get-TssConfiguration
[Search-TssDistributedEngineSite]:/thycotic.secretserver/commands/distributed-engine/Search-TssDistributedEngineSite
