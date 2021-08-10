---
sort: 3
---

# Compatibility

Secret Server REST API was first released with version 9.0. The API has grown since then and continues to grow as the product evolves. The module is tested on the latest Secret Server release available. This page aims to provide a list of endpoints that are only available in specific build versions of Secret Server.

> The starting version for maintaining this content will be Secret Server 10.9.

> Each function included below will have a version check on Secret Server before the endpoint is called.

## Function List

> The Secret Server version listed is the minimum required to use the function.

| **Function Name**                   | **Secret Server Version** |
| ----------------------------------- | ------------------------- |
| [Get-TssConfiguration]              | 10.9.000032               |
| [Search-TssDistributedEngineSite]   | 10.9.000032               |
| [Get-TssSecretAudit]                | 10.9.000032               |
| [Get-TssSecretState]                | 10.9.000032               |
| [Get-TssUserRoleAssigned]           | 10.9.000032               |
| [Search-TssMetadata]                | 10.9.000064               |
| [Get-TssFolder] (-FolderPath param) | 11.0.000000               |
| [Get-TssSecret] (-Path param)       | 11.0.000000               |
| [Get-TssSecretPolicy]               | 11.0.000000               |
| [Set-TssSecretPolicy]               | 11.0.000000               |
| [Search-TssSystemLog]               | 11.0.000000               |

[Get-TssSecretAudit]:/thycotic.secretserver/commands/secrets/Get-TssSecretAudit
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned
[Get-TssSecretState]:/thycotic.secretserver/commands/secrets/Get-TssSecretState
[Get-TssConfiguration]:/thycotic.secretserver/commands/configurations/Get-TssConfiguration
[Search-TssDistributedEngineSite]:/thycotic.secretserver/commands/distributed-engine/Search-TssDistributedEngineSite
[Search-TssMetadata]:/thycotic.secretserver/commands/metadata/Search-TssMetadata
[Get-TssFolder]:/thycotic.secretserver/commands/folders/Get-TssFolder
[Get-TssSecret]:/thycotic.secretserver/commands/secrets/Get-TssSecret
[Get-TssSecretPolicy]:/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicy
[Set-TssSecretPolicy]:/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy
[Search-TssSystemLog]:/thycotic.secretserver/commands/diagnostics/Search-TssSystemLog