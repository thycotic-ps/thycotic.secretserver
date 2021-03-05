---
title: "Compatibility"
permalink: /docs/compatibility/
excerpt: "Module Compatibility"
last_modified_at: 2021-03-03T00:00:00-00:00
toc: false
---

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
[Get-TssUserRoleAssigned]           | 10.9.000032
[Get-TssSecretAudit]                | 10.9.000032
[Get-TssSecretState]                | 10.9.000032

[Get-TssSecretAudit]:/thycotic.secretserver/commands/Get-TssSecretAudit
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/Get-TssUserRoleAssigned
[Get-TssSecretState]:/thycotic.secretserver/commands/Get-TssSecretState
