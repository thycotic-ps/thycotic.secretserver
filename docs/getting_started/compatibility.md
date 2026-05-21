---
parent: Getting Started
nav_order: 3
---

# Compatibility

Secret Server REST API was first released with version 9.0. The API has grown since then and continues to grow as the product evolves. This page lists endpoints that are only available in specific build versions of Secret Server.

> The starting version for maintaining this content is Secret Server 10.9.

> Each function included below has a version check on Secret Server before the endpoint is called.

## Response handling improvements in 0.62.0

Secret Server has added and renamed REST response properties across many releases. When the module's typed C# classes don't yet model a newly-added property, cmdlets that cast the response into one of those types fail with `Cannot convert value ... to type Thycotic.PowerShell.<...>`. The errors are not specific to any one Secret Server release — they show up whenever the deployed Secret Server returns fields the module's class definitions don't recognize.

Module v0.62.0 addresses this in two ways:

- A general `FilterTssResponse` pass is now applied by all functions before the type cast. Unknown properties are stripped (and reported via `Write-Verbose`) instead of breaking the cast.
- Three cmdlets received targeted fixes for nested-object cast failures that the general pass alone couldn't handle: `Get-TssConfiguration`, `Get-TssRpcPasswordType`, and `Get-TssDirectoryServiceSyncStatus`.

If you've been seeing `Cannot convert value` errors on older module releases, upgrading to v0.62.0 should resolve them regardless of which Secret Server version you're running. See [CHANGELOG](https://github.com/thycotic-ps/thycotic.secretserver/blob/dev/CHANGELOG.md) for the full list of fixes.

## Function List

> The Secret Server version listed is the minimum required to use the function.

| **Function Name**                   | **Secret Server Version** |
| ----------------------------------- | ------------------------- |
| [Export-TssAutoExportStorageItem]   | 11.0.000005               |
| [Get-TssConfigurationAutoExport]    | 11.0.000005               |
| [Get-TssConfiguration]              | 10.9.000032               |
| [Get-TssFolder] (-FolderPath param) | 11.0.000005               |
| [Get-TssMetadataField]              | 10.9.000064               |
| [Get-TssReportSchedule]             | 10.9.000032               |
| [Get-TssSecret] (-Path param)       | 11.0.000005               |
| [Get-TssSecretAudit]                | 10.9.000032               |
| [Get-TssSecretPolicy]               | 11.0.000005               |
| [Get-TssSecretPolicyStub]           | 11.0.000005               |
| [Get-TssSecretState]                | 10.9.000032               |
| [Get-TssUserRoleAssigned]           | 10.9.000032               |
| [New-TssMetadataField]              | 10.9.000064               |
| [New-TssSecretPolicy]               | 11.0.000005               |
| [Remove-TssMetadata]                | 11.0.000005               |
| [Remove-TssReportSchedule]          | 10.9.000033               |
| [Search-TssAutoExportStorage]       | 11.0.000005               |
| [Search-TssConfigurationBackupLog]  | 11.0.000005               |
| [Search-TssDistributedEngineSite]   | 10.9.000032               |
| [Search-TssMetadata]                | 10.9.000064               |
| [Search-TssMetadataHistory]         | 10.9.000064               |
| [Search-TssSystemLog]               | 11.0.000005               |
| [Set-TssSecretPolicy]               | 11.0.000005               |
| [Set-TssConfigurationAutoExport]    | 11.0.000005               |

[Get-TssSecretAudit]:/thycotic.secretserver/commands/secrets/Get-TssSecretAudit
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned
[Get-TssSecretState]:/thycotic.secretserver/commands/secrets/Get-TssSecretState
[Get-TssConfiguration]:/thycotic.secretserver/commands/configurations/Get-TssConfiguration
[Search-TssDistributedEngineSite]:/thycotic.secretserver/commands/distributed-engine/Search-TssDistributedEngineSite
[Search-TssMetadata]:/thycotic.secretserver/commands/metadata/Search-TssMetadata
[Get-TssFolder]:/thycotic.secretserver/commands/folders/Get-TssFolder
[Get-TssSecret]:/thycotic.secretserver/commands/secrets/Get-TssSecret
[Get-TssSecretPolicy]:/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicy
[Get-TssSecretPolicyStub]:/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyStub
[Set-TssSecretPolicy]:/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy
[Search-TssSystemLog]:/thycotic.secretserver/commands/diagnostics/Search-TssSystemLog
[Remove-TssMetadata]:/thycotic.secretserver/commands/metadata/Remove-TssMetadata
[Get-TssMetadataField]:/thycotic.secretserver/commands/metadata/Get-TssMetadataField
[New-TssMetadataField]:/thycotic.secretserver/commands/metadata/New-TssMetadataField
[Search-TssMetadataHistory]:/thycotic.secretserver/commands/metadata/Search-TssMetadataHistory
[Remove-TssReportSchedule]:/thycotic.secretserver/commands/reports/Remove-TssReportSchedule
[Get-TssReportSchedule]:/thycotic.secretserver/commands/reports/Get-TssReportSchedule
[Get-TssConfigurationAutoExport]:/thycotic.secretserver/commands/configurations/Get-TssConfigurationAutoExport
[Set-TssConfigurationAutoExport]:/thycotic.secretserver/commands/configurations/Set-TssConfigurationAutoExport
[Search-TssAutoExportStorage]:/thycotic.secretserver/commands/configurations/Search-TssAutoExportStorage
[Export-TssAutoExportStorageItem]:/thycotic.secretserver/commands/configurations/Export-TssAutoExportStorageItem
[Search-TssConfigurationBackupLog]:/thycotic.secretserver/commands/configurations/Search-TssConfigurationBackupLog
[New-TssSecretPolicy]:/thycotic.secretserver/commands/configurations/New-TssSecretPolicy