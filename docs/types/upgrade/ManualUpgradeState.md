---
title: ManualUpgradeState
parent: Upgrade
grand_parent: Types
---

# ManualUpgradeState

**Kind:** class  
**Full name:** `Thycotic.PowerShell.Upgrade.ManualUpgradeState`  
**Namespace:** `Thycotic.PowerShell.Upgrade`  

## Constructors

- `new()` _(default)_

## Properties

| Name | Type | Access | Default |
|---|---|---|---|
| `ApplicationFileLocation` | `string` | read/write | - |
| `AppPoolHasDiskAccessApplication` | `bool` | read/write | - |
| `AppPoolHasDiskAccessTemp` | `bool` | read/write | - |
| `AreSqlDeltasVerified` | `bool` | read/write | - |
| `BlockingVersions` | `string[]` | read/write | - |
| `CanSetIgnoreVersionMismatch` | `bool` | read/write | - |
| `CanSetReadOnlyMode` | `bool` | read/write | - |
| `CanUpgradeVersion` | `bool` | read/write | - |
| `CurrentVersion` | `string` | read/write | - |
| `DownloadedPatchVersionName` | `string` | read/write | - |
| `HasOtherNodes` | `bool` | read/write | - |
| `IsApplicationZipFileDownloaded` | `bool` | read/write | - |
| `IsIgnoreVersionMismatchEnabled` | `bool` | read/write | - |
| `IsReadOnlyModeEnabled` | `bool` | read/write | - |
| `IsSqlReplicationEnabled` | `bool` | read/write | - |
| `IsSqlScriptGenerated` | `bool` | read/write | - |
| `IsStagingTestSuccessful` | `bool` | read/write | - |
| `IsUpgradeFinishedOnAllNodes` | `bool` | read/write | - |
| `IsUpgradeSuccessfulOnCurrentNode` | `bool` | read/write | - |
| `ManualUpgradeZipFileName` | `string` | read/write | - |
| `SqlScriptGenerateFailed` | `bool` | read/write | - |
| `TempFileLocation` | `string` | read/write | - |
| `UpgradeContainsSqlDeltaUpdates` | `bool` | read/write | - |
| `VerifySqlScriptFailed` | `bool` | read/write | - |
